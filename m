Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264238AbRFXPH0>; Sun, 24 Jun 2001 11:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264241AbRFXPHQ>; Sun, 24 Jun 2001 11:07:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7942 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264238AbRFXPHD>;
	Sun, 24 Jun 2001 11:07:03 -0400
Date: Sun, 24 Jun 2001 12:06:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Tom Sightler <ttsig@tuxyturvy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Mike Galbraith <mikeg@wen-online.de>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
In-Reply-To: <20010624092038.A242@bee.lk>
Message-ID: <Pine.LNX.4.21.0106241205190.7419-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001, Anuradha Ratnaweera wrote:

> It is not uncommon to have a large number of tmp files on the disk(s)
> (Rik also pointed this out somewhere early in the original thread) and
> it is sensible to keep all of them in buffers if RAM is sufficient.
> Transfering _very_ large files is not _that_ common so why shouldn't
> that case be handled from the user space by calling sync(2)?

Wait a moment.

The only observed bad case I've heard about here is
that of large files being written out.

It should be easy enough to just trigger writeout of
pages of an inode once that inode has more than a
certain amount of dirty pages in RAM ... say, something
like freepages.high ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

