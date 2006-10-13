Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWJMK0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWJMK0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWJMK0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:26:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:28566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751196AbWJMK0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:26:13 -0400
Date: Fri, 13 Oct 2006 12:25:50 +0200
From: Holger Macht <hmacht@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH] Add support for the generic backlight device to the IBM ACPI driver
Message-ID: <20061013102550.GE4234@homac.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	len.brown@intel.com
References: <20061009113235.GA4444@homac.suse.de> <20061011201027.a4be98c4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011201027.a4be98c4.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11. Oct - 20:10:27, Andrew Morton wrote:
> On Mon, 9 Oct 2006 13:32:35 +0200
> Holger Macht <hmacht@suse.de> wrote:
> 
> > @@ -200,6 +200,7 @@ config ACPI_ASUS
> >  config ACPI_IBM
> >  	tristate "IBM ThinkPad Laptop Extras"
> >  	depends on X86
> > +	select BACKLIGHT
> 
> drivers/acpi/Kconfig:210:warning: 'select' used by config symbol 'ACPI_IBM' refer to undefined symbol 'BACKLIGHT'
> 
> select really sucks :(

Of course it has to be BACKLIGHT_DEVICE. I've sent an updated version of
the patch together with the adjustments of the asus_acpi and toshiba_acpi
drivers.

Regards,
	Holger
