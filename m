Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWEDLgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWEDLgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 07:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWEDLgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 07:36:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:52704 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750929AbWEDLgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 07:36:51 -0400
Date: Thu, 4 May 2006 13:31:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: www.softpanorama.org: sparc_vs_x86 fun
In-Reply-To: <200605041224.41827.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0605041322070.24957@yvahk01.tjqt.qr>
References: <200605041224.41827.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Solaris is heterogeneous OS that (unlike Linux) can perform well on two 
>>architectures: UltraSparc and Intel.

There are a lot of places where there seem to be artificial delays.

>>5.1.  UltraSparc is an expensive but pretty cool CPU :-)
>>...
>>* Energy efficiency: it consumes less energy then either Intel or Opteron
>>  and much less then PoewerPC CPUs.

Approx 82-85 W for an Opteron 244; according to Wikipedia, a T1 is 79 W.
UltraSPARC IV at 109 W (competes with P4 :p)

>>* Fault tolerance. Sun servers can do amazing things with fauly components.
>>  almost any of them can be switched off. Even low level Sun server like V240
>>  can survive bam memory chips, onle falty CPU and one burned power supply.
>>  In some somce it is an cheap cluster.

I once pulled one power cable from a 2-PSU E250 machine. It powered off. 
That can't be fault tolerant.
Plus you can't replace components (in an E250) without turning the power 
off. That's because opening the case disconnects the power circle.

>>* Cleaner architecture. Being big Endean CPU with RISC instruction set
>>  provides some complier level advantages in comparison with convoluted
>>  instruction set of X86 line.

Except that the instruction length is a bit shortcoming for 64-bit integer 
math. Under x64, you can do

    movq $biglongconstant, %rax

while on SPARC, it takes 6 instructions (of course, being RISC makes it 
execute differently than x64)

    sethi %g1, $some_upper_bits
    or %g1, $next_bitgroup
    (shift-left)
    or %g1, $next_bitgroup
    (shift-left)
    or %g1, $last_bitgroup

BTW, T1 is cool, but that the 1U version only has space for 1 disk is 
pretty limiting :/


Jan Engelhardt
-- 
