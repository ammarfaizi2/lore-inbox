Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269388AbRHCJRG>; Fri, 3 Aug 2001 05:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHCJQr>; Fri, 3 Aug 2001 05:16:47 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1796 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269375AbRHCJQl>; Fri, 3 Aug 2001 05:16:41 -0400
Date: Fri, 3 Aug 2001 11:16:49 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803111649.A14189@emma1.emma.line.org>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010803002501.00ada0e0@pop.cus.cam.ac.uk> <200108022218.f72MIm8v028137@webber.adilger.int> <5.1.0.14.2.20010803002501.00ada0e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20010803025916.053e2ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20010803025916.053e2ec0@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Anton Altaparmakov wrote:

[dirsync chattr/mount options]
> Me neither. With regards to the parallel discussion on SUS compliance it is 
> probably a good idea to have such a thing in some form anyway (although if 
> I understood the discussion correctly, we really want this to happen by 
> default, not just when some flag is set but then again I never read the 
> standards...).

The standard doesn't really command the behaviour, as it seems, but we
might want to look again after SUS v3 has been released (supposed to
happen later this year) - the SUS compliance was rather on fsync than on
rename/link.

However, I'd rather not choose the default for somebody else, because he
may have different requirements, a compile-time switch to set the
default should be fine, THIS one might indeed default to dirsync/noasync
unless changed by make {x,menu,}config.

Assuming that the chattr +S is accompanied by a corresponding -o sync
mount option, I'd expect that the dirsync option be available as chattr
option and as mount option, and choosing default mount options should be
rather easy.
