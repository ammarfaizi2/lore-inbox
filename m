Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSBSLUY>; Tue, 19 Feb 2002 06:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291253AbSBSLUT>; Tue, 19 Feb 2002 06:20:19 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:11763 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291251AbSBSLT6>;
	Tue, 19 Feb 2002 06:19:58 -0500
Date: Tue, 19 Feb 2002 04:19:52 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Q: use of new modules in old kernel
Message-ID: <20020219041952.K24428@lynx.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020219090253.CD89D67ED@penelope.materna.de> <1014116037.2019.7.camel@stinky.pussy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014116037.2019.7.camel@stinky.pussy>; from NyQuist@ntlworld.com on Tue, Feb 19, 2002 at 10:53:57AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-19 at 09:02, Tobias Wollgam wrote:
> how is it possible to use modules of newer kernels in an old kernel 
> system?
> 
> To use new drivers, we want not recompile the kernel.
> 
> I tried to load the module 8139too from 2.4.17 into a 2.4.9 kernel with 
> modprobe, but there are many unresolved symbols. 
> 
> The flag "Set version information on all module symbols" is set.

Note that you will basically never be able to just move the compiled module
from one kernel version to another and expect it to work.  At the very
minimum you should copy the needed files from the new kernel source into
the old kernel source and recompile.  Practically, this may also not work
(depending on the driver and the kernel) because while there is often
backwards compatibility in newer kernels, the newer driver code may not
compile (properly) with the older kernel (it depends on what part of the
kernel the driver is in, though).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

