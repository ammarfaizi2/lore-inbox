Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJAWmO>; Tue, 1 Oct 2002 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbSJAWmN>; Tue, 1 Oct 2002 18:42:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:38412 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262884AbSJAWmN>; Tue, 1 Oct 2002 18:42:13 -0400
Date: Wed, 2 Oct 2002 00:47:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
Message-ID: <20021001224740.GA30488@atrey.karlin.mff.cuni.cz>
References: <20021001222434.GA2498@elf.ucw.cz> <Pine.LNX.4.33.0210011538090.9127-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210011538090.9127-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This cleans up swsusp a little bit and fixes ide disk corruption on
> > suspend/resume. Please apply,
> 
> It also seems to be doing things with the device manager. Mind explaining 
> those changes too?

Those are forward port of what we had there already. I make IDE child
of PCI device with the controller (in cases its on PCI). That seems
logical place for it and we had it like that in 2.5.30 or
so. ide-disk.c is there to make disk sleep before we go
suspend. Without that, data corruption happens.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
