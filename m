Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287682AbRLaXM1>; Mon, 31 Dec 2001 18:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287681AbRLaXMR>; Mon, 31 Dec 2001 18:12:17 -0500
Received: from tornado.pdcompsys.com ([195.82.99.64]:25229 "HELO
	tornado.pdcompsys.com") by vger.kernel.org with SMTP
	id <S287680AbRLaXMG>; Mon, 31 Dec 2001 18:12:06 -0500
Date: Mon, 31 Dec 2001 23:12:05 +0000 (GMT)
From: Matthew Dickinson <matt@mattd.org>
X-X-Sender: <matt@tornado.pdcompsys.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 / pcmcia-cs / machine check exception
Message-ID: <Pine.LNX.4.33.0112312304400.12629-100000@tornado.pdcompsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm running into a few error setting up a new AJP 7321 (english brand) 
laptop. 
it's an Athlon 1.2Ghz, 384 mb ram, 30gb hdd 
Texas Instruments PCI1420 PCMCIA controller 
VIA vt8231 chipset 

i've suffered problems trying to install RedHat 7.2 on it from the 
beginning. In short, the PCMCIA bus causes the kernel to crash, either 
when compiled into the kernel or as modules. The pcmcia_core.o module 
loads correctly, then "insmod'ing" (or using the initscript) the i82365.o 
or yenta_socket.o causes the kernel to panic. 

#/sbin/insmod i82365.o 
CPU 0: Machine Check Exception 0000000000000007 
Bank 3: b400000000000833 at 3400000000000833 
Kernel Panic: Unable to continue 

I'm now on my 4th revision of kernel (have tried 2.4.7-10, 2.4.16, 2.4.17, 
2.4.18p1) and none work. Also i have tried multiple versions of pcmcia-cs 
(have tried the default RPM package and also the 3.1.30 source). When i 
try to load the modles, i've tried to pass different IRQs to it in thought 
that it might be that, but alas. 

When running on a 2.2.20 kernel, i can insert the modules without any 
crashing.

Basically, i'm baffled as to why the kernel panics.. can anyone shed any 
light on the subject? 

thanks 

Matt 

