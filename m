Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbTIALNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTIALNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:13:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28164 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261208AbTIALNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:13:10 -0400
Date: Mon, 1 Sep 2003 13:13:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jamie Lokier <jamie@shareable.org>
cc: Kars de Jong <jongk@linux-m68k.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030901100807.GB1903@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309011311330.20748-100000@serv>
References: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be>
 <1062407310.13046.6.camel@laptop.locamation.com> <20030901100807.GB1903@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 1 Sep 2003, Jamie Lokier wrote:

> I would prefer that you run the attached program.  It fixes a bug in
> the function which tests whether the problem is in the L1 cache or
> store buffer.  The bug probably didn't affect the test, but it might
> have.

This is the result for a 060:

$ ./a.out
(256) [175,175,11] Test separation: 4096 bytes: pass
(256) [173,175,11] Test separation: 8192 bytes: pass
(256) [176,175,10] Test separation: 16384 bytes: pass
(256) [174,173,11] Test separation: 32768 bytes: pass
(256) [174,175,11] Test separation: 65536 bytes: pass
(256) [175,175,10] Test separation: 131072 bytes: pass
(256) [176,176,10] Test separation: 262144 bytes: pass
(256) [175,175,11] Test separation: 524288 bytes: pass
(256) [173,175,11] Test separation: 1048576 bytes: pass
(256) [174,174,11] Test separation: 2097152 bytes: pass
(256) [176,176,10] Test separation: 4194304 bytes: pass
(256) [177,177,9] Test separation: 8388608 bytes: pass
(256) [175,176,10] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
$ cat /proc/cpuinfo
CPU:            68060
MMU:            68060
FPU:            68060
Clocking:       49.7MHz
BogoMips:       99.53
Calibration:    497664 loops

bye, Roman

