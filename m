Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUILHub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUILHub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUILHua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:50:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:52911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268526AbUILHuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:50:14 -0400
Date: Sun, 12 Sep 2004 00:48:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: Possible dcache BUG
Message-Id: <20040912004812.3544c6de.akpm@osdl.org>
In-Reply-To: <20040912002945.29a976ad@laptop.delusion.de>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040912000354.7243a328@laptop.delusion.de>
	<20040912001626.759e2d17.akpm@osdl.org>
	<20040912002945.29a976ad@laptop.delusion.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
>
> On Sun, 12 Sep 2004 00:16:26 -0700 Andrew Morton (AM) wrote:
> 
>  AM> Random guess: acpi_evaluate_object() is returning an error but is
>  AM> allocating memory anyway.
>  AM> 
>  AM> In acpi_battery_get_status():
>  AM> 
>  AM> 	status = acpi_evaluate_object(battery->handle, "_BST", NULL, &buffer);
>  AM> 	if (ACPI_FAILURE(status)) {
>  AM> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _BST\n"));
>  AM> 		return_VALUE(-ENODEV);
>  AM> 	}
>  AM> 
>  AM> Is that failure path being taken?
> 
>  Is there a way for me to find that out without recompiling and rebooting?

Not sure.  Looks like you need to set CONFIG_ACPI_DEBUG and then put the
right number into /proc/acpi/debug_layer.
