Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVA0XWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVA0XWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVA0XVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:21:44 -0500
Received: from fmr13.intel.com ([192.55.52.67]:45773 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261289AbVA0XTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:19:55 -0500
Subject: Re: [2.6 patch] #ifdef ACPI_FUTURE_USAGE
	acpi_ut_create_pkg_state_and_push
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050127110443.GF28047@stusta.de>
References: <20050127110443.GF28047@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1106867914.2395.2321.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Jan 2005 18:18:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Thu, 2005-01-27 at 06:04, Adrian Bunk wrote:
> The prototype of the unused global function
> acpi_ut_create_pkg_state_and_push was already #ifdef
> ACPI_FUTURE_USAGE'd, but the actual function wasn't.
> 
> Most likely this was a bug in my patch that added
> ACPI_FUTURE_USAGE.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c.old      
> 2005-01-26 22:31:11.000000000 +0100
> +++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c  
> 2005-01-26 22:40:40.000000000 +0100
> @@ -872,7 +885,7 @@
>   * DESCRIPTION: Create a new state and push it
>   *
>  
> ******************************************************************************/
> -
> +#ifdef ACPI_FUTURE_USAGE
>  acpi_status
>  acpi_ut_create_pkg_state_and_push (
>         void                            *internal_object,
> @@ -894,7 +907,7 @@
>         acpi_ut_push_generic_state (state_list, state);
>         return (AE_OK);
>  }
> -
> +#endif  /*  ACPI_FUTURE_USAGE  */
> 
>  /*******************************************************************************
>   *
> 
> 
> 

