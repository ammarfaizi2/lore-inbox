Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290356AbSBFJEO>; Wed, 6 Feb 2002 04:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290361AbSBFJEC>; Wed, 6 Feb 2002 04:04:02 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:51073 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290356AbSBFJDi>; Wed, 6 Feb 2002 04:03:38 -0500
Message-Id: <200202060903.g1693QMp001682@tigger.cs.uni-dortmund.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: "Drew P. Vogel" <dvogel@intercarve.net>, linux-kernel@vger.kernel.org
Subject: Re: opening a bzImage? 
In-Reply-To: Message from Roy Sigurd Karlsbakk <roy@karlsbakk.net> 
   of "Tue, 05 Feb 2002 16:40:48 +0100." <Pine.LNX.4.30.0202051640210.13730-100000@mustard.heime.net> 
Date: Wed, 06 Feb 2002 10:03:26 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> said:
> No. Not yet. I'm trying to put some pressure on them first. Trying to be a
> little polite..

I doubt it very much that the FSF will get into this, the kernel is GPL(ish),
but not by the FSF, but by Linus.

What exactly do you want? A bzImage is essentially a stripped executable,
gzipped and then appended to a bootloader. Once I got inside this (forget
the reason) by simply looking for the gzip header (file(1)'s magic is of
help here), dd(1)'ed the compressed tail to a file, and gunzip(1)'ed the
result. Look at your nearest kernel's build process...

As the executable is compiled with -O2 -fomit-frame-pointer and stripped,
it won't be much use by itself anyway. Probably the System.map file (if
extant) is more useful, or at least required to make sense of the kernel.
Or you could futz around in /dev/{,k}mem...
-- 
Horst von Brand			     http://counter.li.org # 22616
