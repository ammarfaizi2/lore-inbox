Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVALBSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVALBSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVALBSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:18:41 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:33034 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S262973AbVALBSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:18:35 -0500
Message-ID: <41E47ACB.4000905@tuleriit.ee>
Date: Wed, 12 Jan 2005 03:18:03 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DSP like TCP/IP processing in linux kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My goal is to:
- learn more about DSP like TCP/IP processing
- investigate network/transport layer implementation in Linux
- investigate the possibility to increase network performance by SIMD 
processing
- maybe compile some kind of document from my work
- ask lot of questions here :)


There are lot of quite basic questions to think about. The most basic is 
how to cope with SIMD at all.

Hardware
----------
CPU + ext. == DSP?
(+) SIMD (vertical/horisontal vectorized processing)
(-) (??) h/w MAC/shifter/flow control, separate x/y path

* ARM/MIPS/PowerPC/SPARC/x86 - they all have (or planned) somekind of 
SIMD extension but how much theory I can borrow from DSP world for SIMD 
CPUs? (quite a lot I think)
* network processors (Intel,Broadcom etc.) - can I borrow something from 
there? (only maybe how/why work is distributed between multiple cores)


Software (compiler)
--------------------
Is it possible at all to build a framework to cover those different 
ext.'s in common way?
* gcc builtins for particular arch (well, arm,x86,powerpc are there)
* intrinsics. only intel (?)
* somekind of layer above gcc builtins? (ehh...)

Tools
-------
How should I produce SIMD code?
* Which tools I have to work with SIMD ext.? (umm...vim)
* Which way I should choose: "look, feel and think" or pure math and 
modelling? (I don't like J.B.J. Fourier...)


Method
-------
How to start?
* tracing, profiling - squeeze out the performance hotspot and optimize 
it (is the underlying design suitable at all for this?)
* sketch down current implementation in linux and think again about 
whole thing (results after one year...for me :) )
* in networking context: start with the most common part: calculate 
checksums for IP and TCP (I like this idea)
* Forget about it: turn on -ftree-vectorize when gcc 4.x is here (no-no...)
* Forget about it: this kind of tweaking is not for Linux kernel (what 
about RAID-6 driver? :) )


Well, before I look into Documentation/, kernelnewbies.org, source etc. 
I'd like to ask: is it worth to go further? At least I hope so :)


thanks,
Indrek

