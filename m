Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSKTTNb>; Wed, 20 Nov 2002 14:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSKTTNb>; Wed, 20 Nov 2002 14:13:31 -0500
Received: from elin.scali.no ([62.70.89.10]:5386 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S262416AbSKTTN3>;
	Wed, 20 Nov 2002 14:13:29 -0500
Date: Wed, 20 Nov 2002 20:23:04 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Dave Jones <davej@codemonkey.org.uk>
cc: Margit Schubert-While <margit@margit.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-rc2 strange L1 cache values
In-Reply-To: <20021120190112.GC10698@suse.de>
Message-ID: <Pine.LNX.4.44.0211202011291.15336-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Dave Jones wrote:

> On Wed, Nov 20, 2002 at 07:48:27PM +0100, Steffen Persvold wrote:
> 
>  > >  > <6>CPU: L1 I cache: 0K, L1 D cache: 8K
>  > Yep that works (I have two Xeon boxes with the same issue) :
>  > But why does this P4 Trace cache report as L1 I cache on 2.4.18 ? 
> 
> Look again above, and you'll see .18 said it had 0K L1 (which is
> correct, L1 != Trace cache).

The original poster reported on 2.4.20-rc2 (which reports 0K), not 2.4.18. 
The output I provided was from .18 and that clearly says 'L1 I cache:12K'.
Here are some 'sniplets' of my 2.4.18 dmesg :

Linux version 2.4.18-sca8smp (root@r2) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-112)) #1 SMP Wed Nov 6 20:17:23 CET 2002

[snip]

CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) XEON(TM) CPU 1.80GHz stepping 04

>  
>  > Does this have any implications on the 2.4.18 performance (or the 
>  > 2.4.20-rc2 performance without the descriptors.diff) ?
> 
> The SMP weighting should be done with L2 cache size, which
> was correct on .18 too, so it should be ok.

Ok, since this is now fixed (with your patch), I really don't care about 
earlier kernels anyway (however some of my customer might have if it was 
an issue). Do you know if your patch is going into 2.4.20 release (it's a 
rather small and useful patch) ?

Thanks,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

