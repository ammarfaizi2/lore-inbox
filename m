Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135331AbRDLVVA>; Thu, 12 Apr 2001 17:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135330AbRDLVUm>; Thu, 12 Apr 2001 17:20:42 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:65155 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135326AbRDLVU1>; Thu, 12 Apr 2001 17:20:27 -0400
Date: Thu, 12 Apr 2001 23:20:21 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: esr@thyrsus.com, jeff millar <jeff@wa1hco.mv.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
Message-ID: <20010412232021.A682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <002701c0c2f1$fc672960$0201a8c0@home> <20010411225055.A11009@thyrsus.com> <003c01c0c312$73713300$0201a8c0@home> <20010411220646.A12550@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010411220646.A12550@thyrsus.com>; from esr@thyrsus.com on Wed, Apr 11, 2001 at 10:06:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 10:06:46PM -0400, esr@thyrsus.com wrote:
> Editconfig was a mistake.  OK, I think I understand the rules now.  Is it:
> 
> (1) First, try to read from .config
> (2) If .config doesn't exist, read from $(ARCH)/defconfig
> 
> ?

Right. But with the following constraints:

   make oldconfig takes _any_ .config from _any_ kernel and builds a
   new one for _this_ kernel asking any remaining questions
   
   make xconfig, make menuconfig, make config take a .config from
   _this_ kernel and configure for _this_ kernel

   if they don't find and .config, then they fall back to
   $(ARCH)/defconfig


Would be nice, if CML2 works like this too, because it's not nice
to go through all the options again, if I install a new kernel or
just want to change my current kernel config add a module.

But your CML2 is sure great work.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
