Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbTCRQaZ>; Tue, 18 Mar 2003 11:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbTCRQaY>; Tue, 18 Mar 2003 11:30:24 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:61636 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262507AbTCRQaX>; Tue, 18 Mar 2003 11:30:23 -0500
Date: Tue, 18 Mar 2003 16:41:15 +0000 (GMT)
From: Anton Altaparmakov <aia21@cantab.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-ntfs-dev@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: NTFS byte swapping
In-Reply-To: <Pine.GSO.4.21.0303181546500.17808-100000@vervain.sonytel.be>
Message-ID: <Pine.SOL.3.96.1030318163951.16788B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Mar 2003, Geert Uytterhoeven wrote:
> When compiling NTFS support in 2.5.65 on a big-endian machine (m68k), I get:
> 
> | fs/ntfs/compress.c:167: warning: passing arg 1 of `__swab16p' from incompatible pointer type
> | fs/ntfs/compress.c:207: warning: passing arg 1 of `__swab16p' from incompatible pointer type
> | fs/ntfs/compress.c:228: warning: passing arg 1 of `__swab16p' from incompatible pointer type
> | fs/ntfs/compress.c:333: warning: passing arg 1 of `__swab16p' from incompatible pointer type
> 
> The offending code does `le16_to_cpup(cb)', with cb a pointer to a u8.

Thanks for letting us know. I have fixed it now (just doing
le16to_cpup((u16*)cb) instead which should fix the warnings. I will submit
to Linus together with other changes later.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

