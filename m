Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUHFCCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUHFCCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267907AbUHFCCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:02:11 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:17110 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S268049AbUHFCCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:02:07 -0400
Date: Thu, 5 Aug 2004 17:10:17 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040805211017.GA11395@cox.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org> <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 09:26:10AM -0700, Linus Torvalds wrote:
> 
> Anyway, one other thing that makes me worry is the fact that Gene 
> apparently has a K7. One of the things AMD has gotten wrong several times 
> is prefetching, and it so happens that the dcache code is one of the users 
> of the prefetch instruction. prude_dcache() in particular.
> 
> So I'm also entertaining the notion that there's an actual prefetch data 
> corruption, not just the known AMD bug with occasional spurious page 
> faults. Who else has seen the problem? What CPU's are involved?
> 
> 		Linus

Assuming that what I was seeing was the same problem...

chris@peace:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 1002.487
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1982.46


BTW, a recent oops from wli looked similar, but I don't think he's
spoken up in this thread.

He seems busy tracking down other things.

-chris

