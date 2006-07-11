Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWGKKXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWGKKXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWGKKXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:23:05 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:37092 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750956AbWGKKXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:23:04 -0400
Date: Tue, 11 Jul 2006 12:23:02 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       R.E.Wolff@BitWizard.nl
Subject: Re: [Ubuntu PATCH] Add Specialix IO8+ card support hotplug support
Message-ID: <20060711102302.GD26621@bitwizard.nl>
References: <44A98274.2010904@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A98274.2010904@oracle.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 01:47:48PM -0700, Randy Dunlap wrote:
> Patch Description:
> Add "Specialix IO8+ card support" hotplug support

Looks good (untested). 

	Roger. 

> 
> patch location:
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=d795cfc591bb44f6b3d86d8f054a227cecb44bb4
> 
> ---
>  drivers/char/specialix.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- linux-2617-g21.orig/drivers/char/specialix.c
> +++ linux-2617-g21/drivers/char/specialix.c
> @@ -2584,6 +2584,13 @@ static void __exit specialix_exit_module
>  	func_exit();
>  }
>  
> +static struct pci_device_id specialx_pci_tbl[] __devinitdata = {
> +	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_IO8,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, specialx_pci_tbl);
> +
>  module_init(specialix_init_module);
>  module_exit(specialix_exit_module);
>  
> 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
