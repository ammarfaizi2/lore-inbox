Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWBTK12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWBTK12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWBTK12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:27:28 -0500
Received: from [217.147.92.49] ([217.147.92.49]:5030 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964847AbWBTK11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:27:27 -0500
Date: Mon, 20 Feb 2006 10:26:39 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: jayakumar.acpi@gmail.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Message-ID: <20060220102639.GA4342@srcf.ucam.org>
References: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602200213.k1K2DrDW013988@ns1.clipsalportal.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 10:13:53AM +0800, jayakumar.acpi@gmail.com wrote:

> +	/* setup proc entry to set and get lcd brightness */
> +	proc = create_proc_read_entry("lcd", S_IFREG | S_IRUGO | S_IWUSR,
> +			atlas_proc_dir, atlas_read_proc_lcd, atlas_dev);

For basic sanity, could this please be a standard backlight driver 
rather than sticking yet another backlight control under yet another 
directory in /proc? It makes userspace much, much easier. 
drivers/video/backlight/corgi_bl.c is an example, but also see my posts 
to acpi-devel with patches that add it to existing acpi drivers.

> +		return atlas_acpi_button_add(device);

What buttons does the hardware have? Would it make more sense for it to 
be an input driver rather than (or as well as) just dropping stuff in 
acpi/events?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
