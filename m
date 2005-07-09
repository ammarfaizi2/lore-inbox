Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVGIAIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVGIAIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVGIAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:05:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59055 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263001AbVGIAF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:05:27 -0400
Message-ID: <42CF14B2.70700@pobox.com>
Date: Fri, 08 Jul 2005 20:05:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6 patch] SCSI_SATA has to be a tristate
References: <20050708214802.GK3671@stusta.de> <Pine.LNX.4.61.0507090134040.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0507090134040.3743@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Fri, 8 Jul 2005, Adrian Bunk wrote:
> 
> 
>>--- linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig.old	2005-07-02 21:57:40.000000000 +0200
>>+++ linux-2.6.13-rc1-mm1/drivers/scsi/Kconfig	2005-07-02 21:58:06.000000000 +0200
>>@@ -447,7 +447,7 @@
>> source "drivers/scsi/megaraid/Kconfig.megaraid"
>> 
>> config SCSI_SATA
>>-	bool "Serial ATA (SATA) support"
>>+	tristate "Serial ATA (SATA) support"
>> 	depends on SCSI
>> 	help
>> 	  This driver family supports Serial ATA host controllers
> 
> 
> Did you verify that this works?

No, he didn't :)

This option needs to follow the rules for dep_mbool in 2.4.x.  It should 
not be a tristate, but it is dependent on a tristate.

	Jeff



