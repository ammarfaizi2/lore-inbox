Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbTCTM7d>; Thu, 20 Mar 2003 07:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbTCTM7d>; Thu, 20 Mar 2003 07:59:33 -0500
Received: from realityfailure.org ([209.150.103.212]:44683 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id <S261442AbTCTM7b>; Thu, 20 Mar 2003 07:59:31 -0500
Date: Thu, 20 Mar 2003 08:10:12 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: John Bradford <john@grabjohn.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <mirrors@kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <200303200955.h2K9t677000483@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0303200744010.2365-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Among the latest 2.4-release kernels (2.4.19 and 2.4.20), it seems that 
bz2 saves ~6MB.

Downloads: 1.5MB DSL

time `ncftpget ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.gz`
real    3m24.004s
<snipped>

time `ncftpget ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.bz2`
real    2m51.481s
<snipped>

Uncompression: Dual AMD 1600+, 512MB ram, 30 GB seagate EIDE
time `gunzip linux-2.4.20.tar.gz`
real    0m5.428s
user    0m2.285s
sys     0m1.096s

time `bunzip2 linux-2.4.20.tar.bz2 `
real    0m28.892s
user    0m27.318s
sys     0m1.363s

Compression: Dual AMD 1600+, 512MB ram, 30 GB seagate EIDE
time `gzip linux-2.4.20.tar`
real    0m18.771s
user    0m17.990s
sys     0m0.674s

time `gzip -9 linux-2.4.20.tar`
real    0m42.032s
user    0m40.725s
sys     0m0.791s

time `bzip2 linux-2.4.20.tar`
real    1m50.411s
user    1m49.197s
sys     0m0.555s

bz2 is about 18% of the size of the tarfile. gz is 22%. gzip -9 saved a 
whopping 310k compared to gzip.

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.


