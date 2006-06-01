Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965315AbWFAVbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbWFAVbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbWFAVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:31:15 -0400
Received: from xenotime.net ([66.160.160.81]:1736 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965315AbWFAVbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:31:14 -0400
Date: Thu, 1 Jun 2006 14:33:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: anssi.hannula@gmail.com
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: input: fix comments and blank lines in new ff code
Message-Id: <20060601143356.f5b8d4f5.rdunlap@xenotime.net>
In-Reply-To: <20060601204716.GA6847@delta.onse.fi>
References: <20060530105705.157014000@gmail.com>
	<20060530110131.136225000@gmail.com>
	<20060530222122.069da389.rdunlap@xenotime.net>
	<447F3AE4.6010206@gmail.com>
	<20060601125256.de2897f4.rdunlap@xenotime.net>
	<447F47FD.2050705@gmail.com>
	<20060601130923.38f83fb6.rdunlap@xenotime.net>
	<20060601204716.GA6847@delta.onse.fi>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 23:47:16 +0300 Anssi Hannula wrote:

> From: Anssi Hannula <anssi.hannula@gmail.com>
> 
> Fix comments so that they conform to kernel-doc or remove ** if they are
> not in kernel-doc format.
> Akso add/remove some blank lines.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> ---
> 
> Note that the From header of my email is different as otherwise
> osdl.org would mark my email as spam. Please use my gmail.com address.

What's up with that?  OSDL filters are overly strong?


> Index: linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c
> ===================================================================
> --- linux-2.6.17-rc4-git12.orig/drivers/usb/input/hid-pidff.c	2006-06-01 18:51:39.000000000 +0300
> +++ linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c	2006-06-01 23:24:47.000000000 +0300
> @@ -914,16 +925,17 @@ static int pidff_reports_ok(struct input
>  	return 1;
>  }
>  
> -/**
> - * Find a field with a specific usage within a report
> - * @report: The report from where to find
> - * @usage: The wanted usage
> +/*
> + * pidff_find_logical_field - find a field with a specific logical usage
> + * @report: the report from where to find
> + * @usage: the wanted usage
>   * @enforce_min: logical_minimum should be 1, otherwise return NULL
>   */

Comment does not match function name.

>  static struct hid_field *pidff_find_special_field(struct hid_report *report,
>  						  int usage, int enforce_min)
>  {
>  	int i;
> +
>  	for (i = 0; i < report->maxfield; i++) {
>  		if (report->field[i]->logical == (HID_UP_PID | usage)
>  		    && report->field[i]->report_count > 0) {


And I noticed one function name _input_ff_erase().
That might be a namespace violation... anyone know the namespace
rules?

Otherwise all looks good to me.

---
~Randy
