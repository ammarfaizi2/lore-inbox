Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbRLBVcA>; Sun, 2 Dec 2001 16:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281811AbRLBVbi>; Sun, 2 Dec 2001 16:31:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21519 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281817AbRLBVbV>; Sun, 2 Dec 2001 16:31:21 -0500
Message-ID: <3C0A9D8D.4CC463A0@zip.com.au>
Date: Sun, 02 Dec 2001 13:30:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Results from 2.4.17-pre2 plus the attached patch:  1135 bytes saved in
> vmlinux, simply from making all the functions static.
> (*.orig is prior to my patch.  kernel is P2 SMP-based)
> > [jgarzik@rum linux-e2all]$ ls -l vmlinux* arch/i386/boot/bzImage*
> > -rw-r--r--    1 jgarzik  jgarzik   1030259 Dec  2 06:18 arch/i386/boot/bzImage
> > -rw-r--r--    1 jgarzik  jgarzik   1030263 Dec  2 06:04 arch/i386/boot/bzImage.orig
> > -rwxr-xr-x    1 jgarzik  jgarzik   2814631 Dec  2 06:18 vmlinux*
> > -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 06:04 vmlinux.orig*
> 

but, but, but...   That's on-disk size.

What does /usr/bin/size say?

And don't forget http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/inline.patch
which deletes 61 `inline's and save 12 kbytes.  We really, really
need to examine our use of inlines.  It's probable that we're
sloshing squigabytes of instructions across the external memory bus
quite unnecessarily.

-
