Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266195AbRF3PBW>; Sat, 30 Jun 2001 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266196AbRF3PBM>; Sat, 30 Jun 2001 11:01:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25100 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266195AbRF3PBE>;
	Sat, 30 Jun 2001 11:01:04 -0400
Date: Sat, 30 Jun 2001 16:01:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: alan@lxorguk.ukuu.org.uk, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010630160101.G12788@flint.arm.linux.org.uk>
In-Reply-To: <200106301457.HAA14801@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106301457.HAA14801@adam.yggdrasil.com>; from adam@yggdrasil.com on Sat, Jun 30, 2001 at 07:57:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 07:57:10AM -0700, Adam J. Richter wrote:
> 	So, I guess something like Keith Owens's patch would be the
> way to go, with some additional definitions (CONFIG_AGP, CONFIG_PCI,
> CONFIG_ISA, CONFIG_EISA, CONFIG_PCMCIA, and possibly others).  I am
> not sure which other conditionals might also be incorrectly ignored by
> some instances of dep_xxx.  Below, I have included a list of the 52
> CONFIG_* variables that are used as arguments to dep_xxx in 2.4.6-pre6
> and appear in arch/*/config.in.

I have confirmed that Keith Owens patch doesn't work with xconfig - you
can't select any option which has been define_bool'd to 'n'.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

