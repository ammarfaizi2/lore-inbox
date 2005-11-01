Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKAOX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKAOX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKAOX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:23:56 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43917 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750810AbVKAOXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:23:55 -0500
Subject: Re: [PATCH] TPM compile fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <20051031233307.GV7991@shell0.pdx.osdl.net>
References: <20051031233307.GV7991@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 08:24:27 -0600
Message-Id: <1130855067.4882.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Kylene Hall <kjhall@us.ibm.com>

On Mon, 2005-10-31 at 15:33 -0800, Chris Wright wrote:
> Current tree doesn't build (at least on x86_64) due to TPM breakage:
> 
>   CC      drivers/char/tpm/tpm_nsc.o
> drivers/char/tpm/tpm_nsc.c:277: error: `platform_bus_type' undeclared here (not in a function)
> ...
>   CC      drivers/char/tpm/tpm_atmel.o
> drivers/char/tpm/tpm_atmel.c:175: error: `platform_bus_type' undeclared here (not in a function)
> 
> Make sure to include proper headers.
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> ---
> 
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -19,6 +19,7 @@
>   * 
>   */
>  
> +#include <linux/platform_device.h>
>  #include "tpm.h"
>  
>  /* Atmel definitions */
> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
> --- a/drivers/char/tpm/tpm_nsc.c
> +++ b/drivers/char/tpm/tpm_nsc.c
> @@ -19,6 +19,7 @@
>   * 
>   */
>  
> +#include <linux/platform_device.h>
>  #include "tpm.h"
>  
>  /* National definitions */
> 

