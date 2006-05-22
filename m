Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWEVDIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWEVDIa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWEVDI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:08:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:56763 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964996AbWEVDI3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:08:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c9k5ZdlEdY+ilrdHPgeICdW5wzhtUHbD7umUZH2FX1uQULPyjhvHn8pcY0lKA0fZniWZ/B2/RCJHUYx6hgRb4aOJfpyrWfSp0MN3H5nNlNX3b8DfJRGC2NdlbgWaw1QZztmzCNcfB6vw8N2KVtKSXCFjeTvQrK7jroLihAYPL3E=
Message-ID: <756b48450605212008m76e93eeav35d0e0bc8cfa9979@mail.gmail.com>
Date: Mon, 22 May 2006 11:08:28 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 2.6.17-rc4 1/1] ACPI: Atlas ACPI driver v2
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060522005501.GA25434@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605190153.k4J1rW0U002537@localhost.localdomain>
	 <20060522005501.GA25434@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, Pavel Machek <pavel@ucw.cz> wrote:
> > +     set_bit(KEY_F1 ,input_dev->keybit);
>
> ", " please... and are you sure you want it as a F1..F9 keys?

Will correct the ",", it was a typo. I picked F1 through F9 because
distributors are free to label the fascia of the panel as they wish. I
figured F1 through F9 would be a sufficiently generic selection. What
do you recommend?

> > +/* button handling code */
> > +static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
> > +                 u32 function, void *handler_context, void **return_context)
> > +{
> > +     *return_context =
> > +             (function != ACPI_REGION_DEACTIVATE) ?  handler_context : NULL;
>
> Too many spaces after ? I'd say.

Agreed. Will correct.

>
> > +static struct acpi_driver atlas_acpi_driver = {
> > +     .name   = ACPI_ATLAS_NAME,
> > +     .class  = ACPI_ATLAS_CLASS,
> > +     .ids    = ACPI_ATLAS_BUTTON_HID,
> > +     .ops = {
> > +             .add = atlas_acpi_button_add,
> > +             .remove = atlas_acpi_button_remove,
> > +             },
> > +};
>
> Watch that whitespace...

Done. And I'll remove that proc define.

Thanks,
jayakumar


>                                                                Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
