Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUEFIRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUEFIRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUEFIRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 04:17:23 -0400
Received: from mail.convergence.de ([212.84.236.4]:61082 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261605AbUEFIRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 04:17:21 -0400
Message-ID: <4099F48F.2090307@convergence.de>
Date: Thu, 06 May 2004 10:17:19 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jean Delvare <khali@linux-fr.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6]
References: <409923F7.7050101@convergence.de> <20040505175323.GA13088@kroah.com>
In-Reply-To: <20040505175323.GA13088@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 05/05/04 19:53, Greg KH wrote:
>>I think these things are unquestionable and don't make any functional 
>>changes to the code, so this should be applied to 2.6 now.

> Now as in I'll add it to my i2c tree, which will get picked up by -mm
> and let it bake a bit and then pushed to Linus, yes.

This is how I meant it.

Quoting your other mail:

 > Looks good, I've applied this to my trees, and it will show up in the
 > next -mm release.

Ok, thanks. As my time permits it, I'll prepare patches to add class 
entries to the i2c adapters and i2c clients.

But I won't be sad if the sensors people make the changes to their 
drivers themselves. ;-)

(ie. mostly remove
 >	if (!(adapter->class & I2C_CLASS_SMBUS))
 >		return 0;
from the xxx_attach_adapter() funtion (the check will be done in the 
i2c-core and add a .class = I2C_CLASS_SMBUS to the xxx_driver static 
variable)

> greg k-h

CU
Michael.
