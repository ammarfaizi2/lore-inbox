Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSE1Up4>; Tue, 28 May 2002 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSE1UoA>; Tue, 28 May 2002 16:44:00 -0400
Received: from [195.39.17.254] ([195.39.17.254]:64412 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316939AbSE1UnD>;
	Tue, 28 May 2002 16:43:03 -0400
Date: Mon, 27 May 2002 13:44:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Steve Whitehouse <Steve@ChyGwyn.com>,
        linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
Subject: Re: Kernel deadlock using nbd over acenic driver
Message-ID: <20020527134413.E35@toy.ucw.cz>
In-Reply-To: <200205241011.LAA26311@gw.chygwyn.com> <200205241143.g4OBh1332485@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Look in some of the block drivers, floppy.c or loop.c.  These do call
> the task queue, even though that's only as an aid to the rest of the
> kernel, because they know they can help at that point, and it's not at
> all clear what context they're in.  Perhaps it's best to look in
> floppy.c, which runs the task queue in its init routine!  I mean to say

Init routine is called from insmod context or at kernel bootup (from pid==1).

Both look like process context to me.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

