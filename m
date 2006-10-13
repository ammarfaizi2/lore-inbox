Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWJMV5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWJMV5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWJMV5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:57:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030212AbWJMV5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:57:03 -0400
Date: Fri, 13 Oct 2006 14:56:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Holger Macht <hmacht@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [PATCH 3/3] Add support for the generic backlight device to the
 TOSHIBA ACPI driver
Message-Id: <20061013145658.99de9f54.akpm@osdl.org>
In-Reply-To: <20061013102419.GD4234@homac.suse.de>
References: <20061013102419.GD4234@homac.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 12:24:19 +0200
Holger Macht <hmacht@suse.de> wrote:

> +static int set_lcd(int value)
> +{
> +	u32 hci_result;
> +
> +	value = value << HCI_LCD_BRIGHTNESS_SHIFT;
> +	hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
> +	if (hci_result != HCI_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;

-EFAULT seems a bit random.  Would -EIO be more appropriate?
