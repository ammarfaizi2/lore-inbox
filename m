Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVD3Hfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVD3Hfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 03:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVD3Hfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 03:35:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34221 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262294AbVD3HfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 03:35:21 -0400
Date: Sat, 30 Apr 2005 08:35:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: tighten i2c dependancies
Message-ID: <20050430073518.GB22673@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20050430055745.GB832@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430055745.GB832@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 01:57:45AM -0400, Dave Jones wrote:
>  config I2C_ALI15X3
>  	tristate "ALI 15x3"
> -	depends on I2C && PCI && EXPERIMENTAL
> +	depends on X86 && I2C && PCI && EXPERIMENTAL
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  Acer Labs Inc. (ALI) M1514 and M1543 motherboard I2C interfaces.

one of the ali bridges is used on sparc64 aswell, not sure which one.

> @@ -41,7 +41,7 @@ config I2C_ALI15X3
>  
>  config I2C_AMD756
>  	tristate "AMD 756/766/768/8111 and nVidia nForce"
> -	depends on I2C && PCI && EXPERIMENTAL
> +	depends on X86 && I2C && PCI && EXPERIMENTAL
>  	help
>  	  If you say yes to this option, support will be included for the AMD
>  	  756/766/768 mainboard I2C interfaces.  The driver also includes

also used on alpha and ppc64


>  config I2C_AMD8111
>  	tristate "AMD 8111"
> -	depends on I2C && PCI && EXPERIMENTAL
> +	depends on X86 && I2C && PCI && EXPERIMENTAL
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.

ppc64

>  config I2C_PIIX4
>  	tristate "Intel PIIX4"
> -	depends on I2C && PCI
> +	depends on X86 && I2C && PCI
>  	help
>  	  If you say yes to this option, support will be included for the Intel
>  	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
> @@ -437,7 +437,7 @@ config I2C_STUB

the PIIX is used on various non-x86 systems, at least ppc and mips come to
mind.

