Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVKWCGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVKWCGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVKWCGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:06:15 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:46998 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S965197AbVKWCGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:06:14 -0500
Date: Tue, 22 Nov 2005 18:06:09 -0800
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051123020609.GA30491@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20051122211947.GA29622@bougret.hpl.hp.com> <20051122165429.A30362@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122165429.A30362@unix-os.sc.intel.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:54:29PM -0800, Rajesh Shah wrote:
> On Tue, Nov 22, 2005 at 01:19:47PM -0800, Jean Tourrilhes wrote:
> > 	Hi Rajesh,
> > 
> > 	I have some ACPI trouble, and one of your checkin may be
> > related to it. Would you mind checking the following LKML thread ?
> > 	http://marc.theaimsgroup.com/?t=113268687800002&r=1&w=2
> > 
> Thanks for pointing me here, I wasn't reading this thread...

	Yeah, I know, I don't follow LKML either.
	Note that pci=noacpi did fix my issues. I guess I have a buggy
ACPI :-(

> Does this patch help?

	This patch does not look right to me, but I must admit I have
no clue about what the code is doing. Can you confirm you want me to
try this ?

> thanks,
> Rajesh

	Have fun...

	Jean

>  drivers/acpi/scan.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.14-vanilla/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.14-vanilla.orig/drivers/acpi/scan.c
> +++ linux-2.6.14-vanilla/drivers/acpi/scan.c
> @@ -1111,7 +1111,7 @@ acpi_add_single_object(struct acpi_devic
>  	 *
>  	 * TBD: Assumes LDM provides driver hot-plug capability.
>  	 */
> -	result = acpi_bus_find_driver(device);
> +	acpi_bus_find_driver(device);
>  
>        end:
>  	if (!result)
