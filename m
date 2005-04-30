Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVD3LGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVD3LGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 07:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVD3LGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 07:06:12 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:11993 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S261193AbVD3LGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 07:06:07 -0400
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tighten i2c dependancies
References: <20050430055745.GB832@redhat.com>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 30 Apr 2005 13:06:04 +0200
In-Reply-To: <20050430055745.GB832@redhat.com>
Message-ID: <m34qdosew3.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> A lot of these drivers show up on pretty much every arch
> regardless of whether they make sense. This adds a bunch
> of additional dependancies tying down platform specific drivers
> that are unlikely to be used on other archs.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.11/drivers/i2c/busses/Kconfig~	2005-04-16 01:05:36.000000000 -0400
> +++ linux-2.6.11/drivers/i2c/busses/Kconfig	2005-04-16 01:06:09.000000000 -0400
> @@ -376,7 +376,7 @@ config SCx200_I2C_SDA
>  
>  config SCx200_ACB
>  	tristate "NatSemi SCx200 ACCESS.bus"
> -	depends on I2C && PCI
> +	depends on SCx200_I2C && PCI
>  	help
>  	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.

This is wrong.  The ACCESS.bus driver is an alternative to the
bitbanging driver and it's possible to use this driver even without
any other SCx200 stuff configured into the kernel.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
