Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVCCFNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVCCFNC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVCCFJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:09:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:45247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261465AbVCCFEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:04:33 -0500
Date: Wed, 2 Mar 2005 21:04:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Chapman <jchapman@katalix.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-Id: <20050302210404.2749aed5.akpm@osdl.org>
In-Reply-To: <42235171.80500@katalix.com>
References: <42235171.80500@katalix.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Chapman <jchapman@katalix.com> wrote:
>
> Add DS1337 RTC chip driver.
> 

drivers/i2c/chips/ds1337.c:60: `I2C_DRIVERID_DS1337' undeclared here (not in a function)


Also, there are changes in Greg's i2c tree which break your new driver:

drivers/i2c/chips/ds1337.c:60: initializer element is not constant
drivers/i2c/chips/ds1337.c:60: (near initialization for `ds1337_driver.id')
drivers/i2c/chips/ds1337.c: In function `ds1337_get_datetime':
drivers/i2c/chips/ds1337.c:155: structure has no member named `id'
drivers/i2c/chips/ds1337.c: In function `ds1337_set_datetime':
drivers/i2c/chips/ds1337.c:206: structure has no member named `id'
drivers/i2c/chips/ds1337.c: In function `ds1337_detect':
drivers/i2c/chips/ds1337.c:333: structure has no member named `id'
drivers/i2c/chips/ds1337.c:343: structure has no member named `id'

