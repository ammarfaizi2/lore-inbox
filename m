Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVGIJhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVGIJhB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 05:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbVGIJhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 05:37:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33801 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261595AbVGIJhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 05:37:00 -0400
Date: Sat, 9 Jul 2005 11:36:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation mismatch in Documentation/kbuild/kconfig-language.txt
Message-ID: <20050709093657.GG28243@stusta.de>
References: <Pine.LNX.4.58.0507041639500.24224@be1.lrz> <20050708221756.GM3671@stusta.de> <Pine.LNX.4.58.0507090934510.4231@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507090934510.4231@be1.lrz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 09:37:48AM +0200, Bodo Eggert wrote:
> On Sat, 9 Jul 2005, Adrian Bunk wrote:
> > On Mon, Jul 04, 2005 at 04:59:18PM +0200, Bodo Eggert wrote:
> 
> ...
> > > Therefore I can't use
> > > config SGI_IOC4
> > >     tristate
> > >     prompt "SGI IOC4 Base IO support" if PROMPT_FOR_UNUSED_CORES
> > >     depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
> > >     default n
> ...
> > > Since the "if" is useless, misleading and redundand with this behaviour, I 
> > > suggest stripping it out.
> > 
> > "if" is valuable in "default y" cases.
> 
> It should be, but either it's really applied to the config instead of the 
> prompt (in which can also be added to the depends on list) or the 
> menuconfig '/' function has bogus output.

config FUTEX
        bool "Enable futex support" if EMBEDDED
        default y

This option is always "y" if EMBEDDED=n.
This option is uservisible if EMBEDDED=y.

I don't understand what's not working for you in this case.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

