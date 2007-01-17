Return-Path: <linux-kernel-owner+w=401wt.eu-S1751338AbXAQV4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXAQV4g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXAQV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:56:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:57194 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXAQV4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:56:34 -0500
Message-ID: <45AE9B85.7090608@zytor.com>
Date: Wed, 17 Jan 2007 13:56:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce two new maturlty levels:  DEPRECATED and OBSOLETE.
References: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   To go along with the EXPERIMENTAL kernel config status, introduce
> two new states:  DEPRECATED and OBSOLETE.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   just adding these config variables to init/Kconfig shouldn't affect
> the current build status, but it will allow developers to start to
> move over their portions of tree at their convenience.
> 
>   in particular, features that are truly obsolete should be tagged as
> OBSOLETE, as opposed to EXPERIMENTAL.
> 
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index a3f83e2..f861efd 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -29,9 +29,10 @@ config EXPERIMENTAL
>  	  <file:Documentation/BUG-HUNTING>, and
>  	  <file:Documentation/oops-tracing.txt> in the kernel source).
> 
> -	  This option will also make obsoleted drivers available. These are
> -	  drivers that have been replaced by something else, and/or are
> -	  scheduled to be removed in a future kernel release.
> +	  At the moment, this option also makes obsolete drivers available,
> +	  but such drivers really should be removed from the EXPERIMENTAL
> +	  category and added to either DEPRECATED or OBSOLETE, depending
> +	  on their status.
> 
>  	  Unless you intend to help test and develop a feature or driver that
>  	  falls into this category, or you have a situation that requires
> @@ -40,6 +41,23 @@ config EXPERIMENTAL
>  	  you say Y here, you will be offered the choice of using features or
>  	  drivers that are currently considered to be in the alpha-test phase.
> 
> +config DEPRECATED
> +	bool "Prompt for deprecated code/drivers"
> +	---help---
> +	  Code that has tagged as "deprecated" is officially still available
> +	  for use but will typically have already been scheduled for removal
> +	  at some point, so it's in your best interests to start looking for
> +	  an alternative.
> +

DEPRECATED should presumably default to Y; OBSOLETE to n.

	-hpa
