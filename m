Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268862AbRG0OYg>; Fri, 27 Jul 2001 10:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268864AbRG0OY0>; Fri, 27 Jul 2001 10:24:26 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:4875 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268862AbRG0OYH>; Fri, 27 Jul 2001 10:24:07 -0400
Message-ID: <3B61794C.D407B69E@namesys.com>
Date: Fri, 27 Jul 2001 18:23:08 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: bvermeul@devel.blackstar.nl, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Steve Kieu <haiquy@yahoo.com>,
        Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>, ramon@namesys.com
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7eW-0005cP-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> > > and when that hangs the kernel it will also screw up all files touched
> > > just before it in a edit-make-install-try cycle. Which can be rather
> > > annoying, because you can start all over again (this effect randomly
> > > distributes the last touched sectors to the last touched files. Very nice
> > > effect, but not something I expect from a journalled filesystem).
> > >
> > Do you think it is reasonable to ask that a filesystem be designed to
> > work well with bad drivers?
> 
> Its certainly a good idea. 
I think it is a terrible idea.... at least as a general expectation to meet, there may be specifics
where things can be done though.... like journaling....

> But it sounds to me like he is describing the
> normal effect of metadata only logging.

Ah, right you are.  Now I understand him.  Well, data-journaling that doesn't cost a whole lot of
performance awaits reiser4, and reiser4 is at least a year away, we are doing seminars and
pseudo-coding now.

> 
> Putting a sync just before the insmod when developing new drivers is a good
> idea btw

This makes a lot of sense to me.  Good suggestion.  It should go into our FAQ.  Dad, please put it
there.

Q: I like to dynamically load buggy drivers into the kernel because that is what kernel developers
like me do for fun, how can I better avoid data corruption when doing this and using ReiserFS?

A: Do sync before insmod.  (Alan Cox's good suggestion.)
