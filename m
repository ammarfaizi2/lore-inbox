Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbTEETkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTEETkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:40:22 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:51592 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S261255AbTEETkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:40:17 -0400
Date: Mon, 5 May 2003 21:53:48 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: Joseph Fannin <jhf@rivenstone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: microcode driver fails on PIII-Celeron
In-Reply-To: <Pine.LNX.4.44.0305052150310.4017-100000@einstein31.homenet>
Message-ID: <Pine.LNX.4.44.0305052152340.4017-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

btw, I assume that you have the latest microcode data downloaded from:

http://www.urbanmyth.org/microcode

On Mon, 5 May 2003, Tigran Aivazian wrote:

> This is not a bug. It simply means that there is no microcode data for 
> your processor. So, I recommend disabling invocation of microcode_ctl on 
> startup until there is a latest set of microcode data which contains a 
> chunk for your cpu (i.e. until your cpu has some bugs worthy of fixing :)
> 
> Regards
> Tigran
> 
> On Mon, 5 May 2003, Joseph Fannin wrote:
> 
> >     The microcode driver in the kernel fails for me on my laptop with
> > a PIII-era Celeron 900.  I've tested both 2.4 and 2.5 kernels over
> > course of a year or so; all abort with the same error when trying to
> > load the microcode:
> > 
> > microcode: CPU0 no microcode found! (sig=68a, pflags=32)
> > 
> >     My amateur reading of the code leads me to think the processor
> > might be misidentified somehow (or something, my head doesn't like bit
> > operations).
> > 
> > /proc/cpuinfo:
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 8
> > model name      : Celeron (Coppermine)
> > stepping        : 10
> > cpu MHz         : 897.366
> > cache size      : 128 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
> > bogomips        : 1773.56
> > 
> >     FWIW, this is a Debian unstable system, using the microcode
> > utilities as packaged for Debian.  The laptop is a Dell Inspiron 2500,
> > based on the i815 chipset.
> > 
> >     Is this a bug, or is this really not supposed to work?
> > 
> > --
> > Joseph Fannin
> > jhf@rivenstone.net
> > 
> > "That's all I have to say about that." -- Forrest Gump.
> > 
> 
> 

