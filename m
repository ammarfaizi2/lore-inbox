Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSGLSCU>; Fri, 12 Jul 2002 14:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSGLSCT>; Fri, 12 Jul 2002 14:02:19 -0400
Received: from ns.suse.de ([213.95.15.193]:15123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316673AbSGLSCS>;
	Fri, 12 Jul 2002 14:02:18 -0400
Date: Fri, 12 Jul 2002 20:05:07 +0200
From: Dave Jones <davej@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020712200507.G16956@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0207121934420.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207121934420.8911-100000@serv>; from zippel@linux-m68k.org on Fri, Jul 12, 2002 at 07:40:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 07:40:35PM +0200, Roman Zippel wrote:

 > Please drop this patch, it's impossible to hit this problem and I have a
 > better patch for this.

(whilst on the subject of affs, and whilst I remember..)
btw, affs has been failing fsx runs again for the last few kernels.
truncating to largest ever: 0x13e76
domapwrite: mmap: Invalid argument
LOG DUMP (4 total operations):
1(1 mod 256): TRUNCATE UP   from 0x0 to 0x13e76
2(2 mod 256): WRITE 0x17098 thru 0x26857    (0xf7c0 bytes) HOLE
3(3 mod 256): READ  0xc73e thru 0x1b801 (0xf0c4 bytes)
4(4 mod 256): MAPWRITE 0x32e00 thru 0x331fc (0x3fd bytes)
fsx: save_buffer: short write, 0x30ba8 bytes instead of 0x331fd

This is on an affs image mounted over loopback.
Before/After copies of the image available on request..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
