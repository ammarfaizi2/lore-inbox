Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVA3AHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVA3AHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVA3AHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:07:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:57569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261615AbVA3AHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:07:12 -0500
Message-ID: <41FC232E.2070202@osdl.org>
Date: Sat, 29 Jan 2005 15:58:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maurice Volaski <mvolaski@aecom.yu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_THERM_PM72 is missing from .config from recent kernels
 (2.6.10, 2.6.11)
References: <a0620073dbe21cf061aa6@[129.98.90.227]>
In-Reply-To: <a0620073dbe21cf061aa6@[129.98.90.227]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice Volaski wrote:
> CONFIG_THERM_PM72 is required for thermal management in at least Macs, 
> most notably the PowerMac G5. Without it, the computer will run its fans 
> at the max and is very loud.
> 
> It's missing from .config in at least a few releases of recent kernels 
> (2.6.10, 2.6.11).
> 
> Does anyone know why?

Did you enable/select it?
It's not on by default (in 2.6.11-rc2).

First you need to enable this one:
config I2C_KEYWEST
	tristate "Powermac Keywest I2C interface"
	depends on I2C && PPC_PMAC

and then this one:
config THERM_PM72
	tristate "Support for thermal management on PowerMac G5"
	depends on I2C && I2C_KEYWEST && PPC_PMAC64

-- 
~Randy
