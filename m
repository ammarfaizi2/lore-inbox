Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWEVJdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWEVJdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWEVJdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:33:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750753AbWEVJdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:33:41 -0400
Date: Mon, 22 May 2006 11:33:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jayakumar.acpi@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v3
Message-ID: <20060522093301.GB25624@elf.ucw.cz>
References: <200605220333.k4M3Xkg6020638@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605220333.k4M3Xkg6020638@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 22-05-06 11:33:46, jayakumar.acpi@gmail.com wrote:
> Hi Len, ACPI, and kernel folk,
> 
> Appended is v3 after removing unused defines and whitespace 
> cleanup. Thanks to Pavel Machek for the feedback.
> 
> Please let me know if it looks okay and if you have any feedback
> or suggestions.
> 
> Thanks,
> Jaya Kumar
> 
> Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>

ACK, but I guess you should cc Dmitry (input maintainer) and possibly
Andrew Morton to get it in... Ok, few more nits.

> +#else
> +#define atlas_free_input(...)
> +#define atlas_setup_input(...) 0
> +#define atlas_input_report(...) 
> +#endif

Does the driver actually do anything useful in this case?

> +	}
> +
> +	return status ;

Extra " " before ;.

> +static struct acpi_driver atlas_acpi_driver = {
> +	.name = ACPI_ATLAS_NAME,
> +	.class = ACPI_ATLAS_CLASS,
> +	.ids = ACPI_ATLAS_BUTTON_HID,
> +	.ops = {
> +		.add = atlas_acpi_button_add,
> +		.remove = atlas_acpi_button_remove,
> +		},

Extra tab before }.

> +MODULE_SUPPORTED_DEVICE("Atlas ACPI");

Are you sure this si good idea?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
