Return-Path: <linux-kernel-owner+w=401wt.eu-S1750994AbXACRwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXACRwM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 12:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbXACRwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 12:52:12 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1562 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbXACRwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 12:52:11 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Wed, 3 Jan 2007 18:53:35 +0100
User-Agent: KMail/1.9.5
Cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net> <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g2+mFD/cDRUjCDA"
Message-Id: <200701031853.36145.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_g2+mFD/cDRUjCDA
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, 

> Here's an example program that you can test and time yourself. 
> 
> On my Core 2, I get
> 
> 	[torvalds@woody ~]$ gcc -DCMOV -Wall -O2 t.c
> 	[torvalds@woody ~]$ time ./a.out
> 	600000000
> 
> 	real    0m0.194s
> 	user    0m0.192s
> 	sys     0m0.000s
> 
> 	[torvalds@woody ~]$ gcc -Wall -O2 t.c
> 	[torvalds@woody ~]$ time ./a.out
> 	600000000
> 	
> 	real    0m0.167s
> 	user    0m0.168s
> 	sys     0m0.000s

Test was done on my laptop with gcc 4.1.1 and CPU:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 9
cpu MHz         : 2392.349
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4786.36
clflush size    : 64

I wrote a simple script that run each version of your code 100
times measuring the execution time. Then some simple gnuplot
magic was applied. The result is attached (png file).

- cmovne was faster with almost stable execution time (~171ms)
- je-mov was slower and execution time varies

Interpretation is up to you ;-)

-- 
Regards,

	Mariusz Kozlowski

--Boundary-00=_g2+mFD/cDRUjCDA
Content-Type: image/png;
  name="benchmark.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="benchmark.png"

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
AElFTkSuQmCC

--Boundary-00=_g2+mFD/cDRUjCDA--
