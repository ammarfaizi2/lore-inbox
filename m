Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVIAHD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVIAHD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVIAHD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:03:28 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:6151 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932546AbVIAHD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:03:28 -0400
Date: Thu, 1 Sep 2005 09:03:38 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Grant.Coady@gmail.com
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-mm2
Message-Id: <20050901090338.4b0d72b3.khali@linux-fr.org>
In-Reply-To: <nnolg1tusrn3q5p8qeorks8vhc3cromj8l@4ax.com>
References: <20050822213021.1beda4d5.akpm@osdl.org>
	<nnolg1tusrn3q5p8qeorks8vhc3cromj8l@4ax.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

> adm9240 i2c still broken, spamming debug with:
> (...)
> Aug 23 18:48:40 peetoo kernel: [ 1591.151834] i2c_adapter i2c-0: Transaction (pre): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
> Aug 23 18:48:40 peetoo kernel: [ 1591.170515] i2c_adapter i2c-0: Transaction (post): CNT=08, CMD=2c, ADD=5a, DAT0=00, DAT1=00
> (...)
> As soon as write sysfs.

This is not the adm9240 driver writing this, but the smbus driver for
the SMBus chip your ADM9240 chip is connected to. Which driver is it for
you? lsmod should tell (if not, modprobe i2c-dev && i2cdetect -l
should.)

I suspect that you simply have CONFIG_I2C_DEBUG_BUS enabled. Please
check your .config.

-- 
Jean Delvare
