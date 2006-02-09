Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWBIRvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWBIRvQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422930AbWBIRvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:51:16 -0500
Received: from lizards-lair.paranoiacs.org ([216.158.28.252]:13516 "EHLO
	lizards-lair.paranoiacs.org") by vger.kernel.org with ESMTP
	id S1422929AbWBIRvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:51:15 -0500
Date: Thu, 9 Feb 2006 12:51:08 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: john@neggie.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Message-ID: <20060209175107.GC9810@paranoiacs.org>
Mail-Followup-To: Matthew Garrett <mjg59@srcf.ucam.org>, john@neggie.net,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060207133456.GA2452@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207133456.GA2452@srcf.ucam.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2006 13:34:56 +0000, Matthew Garrett wrote:
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -215,7 +215,7 @@ config ACPI_IBM
>  
>  config ACPI_TOSHIBA
>  	tristate "Toshiba Laptop Extras"
> -	depends on X86
> +	depends on X86 && BACKLIGHT_DEVICE
>  	default y
>  	---help---
>  	  This driver adds support for access to certain system settings

Might this work better:

	config ACPI_TOSHIBA
		depends on X86
		select BACKLIGHT_DEVICE

-
-Ben


-- 
Ben Slusky                  | It was only after their population
sluskyb@paranoiacs.org      | of 50 mysteriously shrank to eight
sluskyb@stwing.org          | that the other seven dwarfs began
PGP keyID ADA44B3B          | to suspect Hungry.
