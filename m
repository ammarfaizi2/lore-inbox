Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVBABDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVBABDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 20:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVBABDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 20:03:34 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:25067 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S261507AbVBABCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 20:02:20 -0500
Mime-Version: 1.0
Message-Id: <a0620074dbe24844b96fe@[129.98.90.227]>
In-Reply-To: <41FC232E.2070202@osdl.org>
References: <a0620073dbe21cf061aa6@[129.98.90.227]>
 <41FC232E.2070202@osdl.org>
Date: Mon, 31 Jan 2005 20:02:45 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: CONFIG_THERM_PM72 is missing from .config from recent kernels
  (2.6.10, 2.6.11)
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maurice Volaski wrote:
>>CONFIG_THERM_PM72 is required for thermal management in at least 
>>Macs, most notably the PowerMac G5. Without it, the computer will 
>>run its fans at the max and is very loud.
>>
>>It's missing from .config in at least a few releases of recent 
>>kernels (2.6.10, 2.6.11).
>>
>>Does anyone know why?
>
>Did you enable/select it?
>It's not on by default (in 2.6.11-rc2).
>
>First you need to enable this one:
>config I2C_KEYWEST
>	tristate "Powermac Keywest I2C interface"
>	depends on I2C && PPC_PMAC
>
>and then this one:
>config THERM_PM72
>	tristate "Support for thermal management on PowerMac G5"
>	depends on I2C && I2C_KEYWEST && PPC_PMAC64
>

Thanks.

This is probably something for the config program designers, but 
options like these shouldn't never be hidden. They should always be 
available. If their prerequisites are not met, then it should reject 
change and throw up an explanation message, namely, the above.
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
