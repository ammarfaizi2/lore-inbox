Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbTIAKf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTIAKf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:35:56 -0400
Received: from sun3.sammy.net ([68.162.198.6]:41999 "HELO sun3.sammy.net")
	by vger.kernel.org with SMTP id S262806AbTIAKfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:35:53 -0400
Date: Mon, 1 Sep 2003 06:35:44 -0400 (EDT)
From: Sam Creasey <sammy@sammy.net>
X-X-Sender: sammy@sun3
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jamie Lokier <jamie@shareable.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.40.0309010632370.19846-100000@sun3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Sep 2003, Geert Uytterhoeven wrote:

> As you probably know the 68020 had an external MMU (68551, or Sun-3 or Apollo
> MMU). Probably Motorola didn't bother to change the behavior when the MMU got
> integrated in later generations (68030 and up).
>
> BTW, probably you want us to run your test program on other m68k boxes? Mine
> got a 68040, that leaves us with:

>   - 68020+Sun-3 MMU

68020+Sun-3 MMU results attached below (this is for a 3/60, and it's not
suprising that it passes, as there's no real cache in this configuration
(the sun3/2xx did have external cache, but the onboard ethernet in my
3/210 is on the fritz, and it's not booting at the moment).  Note that
this is the newer version of the program which Jamie just posted.

bash-2.03# time ./jamie-test2
(2048) [10000,10000,0] Test separation: 8192 bytes: pass
(2048) [10000,10000,0] Test separation: 16384 bytes: pass
(2048) [10000,10000,0] Test separation: 32768 bytes: pass
(2048) [10000,10000,0] Test separation: 65536 bytes: pass
(2048) [10000,10000,0] Test separation: 131072 bytes: pass
(2048) [10000,10000,0] Test separation: 262144 bytes: pass
(2048) [10000,10000,0] Test separation: 524288 bytes: pass
(2048) [10000,10000,0] Test separation: 1048576 bytes: pass
(2048) [10000,10000,0] Test separation: 2097152 bytes: pass
(2048) [10000,10000,0] Test separation: 4194304 bytes: pass
(2048) [10000,10000,0] Test separation: 8388608 bytes: pass
(2048) [10000,10000,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

real    1m34.330s
user    1m30.030s
sys     0m4.070s
bash-2.03# cat /proc/cpuinfo
CPU:            68020
MMU:            Sun-3
FPU:            68881
Clocking:       19.9MHz
BogoMips:       4.97
Calibration:    24896 loops


-- Sam




