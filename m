Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWCXJIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWCXJIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWCXJIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:08:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751457AbWCXJIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:08:46 -0500
Date: Fri, 24 Mar 2006 01:05:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-mm1 x1205 RTC driver doesn't compile
Message-Id: <20060324010517.0dbe8049.akpm@osdl.org>
In-Reply-To: <200603231854.45960.bero@arklinux.org>
References: <200603231854.45960.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> rtc-x1205 uses I2C_DRIVERID_X1205 without defining it.
> 
> Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>
> 
> ---
> --- linux-2.6.16/include/linux/i2c-id.h.ark	2006-03-23 18:56:50.000000000 
> +0100
> +++ linux-2.6.16/include/linux/i2c-id.h	2006-03-23 18:56:22.000000000 +0100
> @@ -108,6 +108,7 @@
>  #define I2C_DRIVERID_UPD64083	78	/* upd64083 video processor	*/
>  #define I2C_DRIVERID_UPD64031A	79	/* upd64031a video processor	*/
>  #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
> +#define I2C_DRIVERID_X1205	81	/* X1205 RTC			*/
>  
>  #define I2C_DRIVERID_I2CDEV	900
>  #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */

But this ID was defined in
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/rtc-subsystem-i2c-driver-ids.patch.
With a different ID, btw.

A patch reject at your end, I suspect.
