Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263854AbUKZV40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbUKZV40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUKZVva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:51:30 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:31139 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262480AbUKZTxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:53:51 -0500
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125215807.GI2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101293918.5805.221.camel@desktop.cunninghams>
	 <20041125170718.GA1417@openzaurus.ucw.cz>
	 <1101418614.27250.21.camel@desktop.cunninghams>
	 <20041125214524.GE2488@elf.ucw.cz>
	 <1101419500.27250.41.camel@desktop.cunninghams>
	 <20041125215807.GI2488@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101420204.27250.54.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:03:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 08:58, Pavel Machek wrote:
> Hi!
> 
> > > > > And if you really want to make it changeable, pass major:minor from userland; once
> > > > > userland is running getting them is easy.
> > > > 
> > > > Yes, but that's also far uglier, and who thinks in terms of major and
> > > > minor numbers anyway? I think of my harddrive as /dev/sda, not 08:xx.
> > > > The parsing accepts majors and minors, of course, but shouldn't we make
> > > > these things easier to do, not harder? (Would we insist on using majors
> > > > and minors for root=?).
> > > 
> > > Kernel interface is not supposed to be "easy". root= has exception,
> > > that's init code, and you can't easily ls -al /dev at that point. If
> > > you want easy interface, create userland program that looks up
> > > minor/major in /dev/ and uses them.
> > 
> > That's a fair possibility, but is it really worth it when all we need to
> > do is make two routines not be init? We would still have to duplicate
> > some of this code elsewhere anyway, because we need to parse the major
> > and minor numbers.
> 
> Parsing major/minor should be as simple as sscanf("%d %d"). And you'll
> have one less modification to generic code. Yes I think it is worth
> it.

In that case, we shouldn't access names at boot time either; the
interface should be consistent, shouldn't it? I really would prefer to
keep things as they are; is it worth all this fuss?

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

