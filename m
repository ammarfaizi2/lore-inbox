Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWEVAzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWEVAzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWEVAzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:55:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51143 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964968AbWEVAzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:55:44 -0400
Date: Mon, 22 May 2006 02:55:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jayakumar.acpi@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v2
Message-ID: <20060522005501.GA25434@elf.ucw.cz>
References: <200605190153.k4J1rW0U002537@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605190153.k4J1rW0U002537@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static int atlas_setup_input(void)
> +{
> +	int err;
> +
> +	input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		printk(KERN_ERR "atlas: insufficient mem to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	input_dev->name = "Atlas ACPI button driver";
> +	input_dev->phys = "acpi/input0";
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
> +	set_bit(KEY_F1 ,input_dev->keybit);	

", " please... and are you sure you want it as a F1..F9 keys?
> +/* button handling code */
> +static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
> +		    u32 function, void *handler_context, void **return_context)
> +{
> +	*return_context = 
> +		(function != ACPI_REGION_DEACTIVATE) ?  handler_context : NULL;

Too many spaces after ? I'd say.

> +static struct acpi_driver atlas_acpi_driver = {
> +	.name 	= ACPI_ATLAS_NAME,
> +	.class 	= ACPI_ATLAS_CLASS,
> +	.ids 	= ACPI_ATLAS_BUTTON_HID, 
> +	.ops = {
> +		.add = atlas_acpi_button_add,
> +		.remove = atlas_acpi_button_remove,
> +		},
> +};

Watch that whitespace...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
