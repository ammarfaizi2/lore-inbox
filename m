Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbVKPMZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbVKPMZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVKPMZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:25:56 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:15086 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1030303AbVKPMZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:25:56 -0500
Message-ID: <437B254E.9040909@shadowconnect.com>
Date: Wed, 16 Nov 2005 13:25:50 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
References: <4379AADD.5000600@shadowconnect.com> <20051115.132836.41612515.davem@davemloft.net>
In-Reply-To: <20051115.132836.41612515.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

David S. Miller wrote:
> From: Markus Lidel <Markus.Lidel@shadowconnect.com>
>>+config I2O_LCT_NOTIFY_ON_CHANGES
>>+	bool "Enable LCT notification"
>>+	depends on I2O
>>+	default y
>>+	---help---
>>+	  Only say N here if you have a I2O controller from SUN. The SUN
>>+	  firmware doesn't support LCT notification on changes. If this option
>>+	  is enabled on such a controller the driver will hang up in a endless
>>+	  loop. On all other controllers say Y.
>>+
>>+	  If unsure, say Y.
>>+
> 
> This should be detected at runtime, and that is easily done.
> You can use the PCI device to get at the firmware device
> node, and use that to look for a firmware device node property
> that identifies it as a card from Sun.
> Usually the "name" property has some identifying string in it.
> Sometimes there is a property with the string "fcode" in it and you
> could look for that as well.

OK, i'll look at it... Thanks for the hint!



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
