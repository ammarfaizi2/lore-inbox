Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757857AbWK0TYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbWK0TYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758524AbWK0TYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:24:33 -0500
Received: from mga03.intel.com ([143.182.124.21]:38557 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757857AbWK0TYc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:24:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,464,1157353200"; 
   d="scan'208"; a="150864812:sNHT2670473736"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
Date: Mon, 27 Nov 2006 11:20:39 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07A5AB43@orsmsx420.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
Thread-Index: AccO+EsMGA8lY0xYRwSVlWZYabVihQDYLEzw
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: <linux-kernel@vger.kernel.org>, <gregkh@suse.de>, <i2c@lm-sensors.org>
X-OriginalArrivalTime: 27 Nov 2006 19:24:21.0800 (UTC) FILETIME=[A41B7280:01C71259]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

I send the patches you requested.  Please let me know if you see anything that needs to change.

Thanks,

Jason



>-----Original Message-----
>From: Jean Delvare [mailto:khali@linux-fr.org]
>Sent: Thursday, November 23, 2006 4:10 AM
>To: Gaston, Jason D
>Cc: linux-kernel@vger.kernel.org; gregkh@suse.de; i2c@lm-sensors.org
>Subject: Re: [PATCH 2.6.19-rc6] i2c-i801: SMBus patch for Intel ICH9
>
>Hi Jason,
>
>On Wed, 22 Nov 2006 15:19:12 -0800, Jason Gaston wrote:
>> This updated patch adds the Intel ICH9 LPC and SMBus Controller DID's.
>> This patch relies on the irq ICH9 patch to pci_ids.h.
>
>Looks good. Care to also update Documentation/i2c/busses/i2c-i801? I
>see it misses at least the ICH8 and ESB2 as well.
>
>I would also appreciate an update to lm_sensors' sensors-detect script,
>if you could send a patch to the sensors list.
>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>>
>> --- linux-2.6.19-rc6/drivers/i2c/busses/i2c-i801.c.orig	2006-11-22
>06:17:20.000000000 -0800
>> +++ linux-2.6.19-rc6/drivers/i2c/busses/i2c-i801.c	2006-11-22
>06:27:12.000000000 -0800
>> @@ -33,6 +33,7 @@
>>      ICH7		27DA
>>      ESB2		269B
>>      ICH8		283E
>> +    ICH9		2930
>>      This driver supports several versions of Intel's I/O Controller Hubs
>(ICH).
>>      For SMBus support, they are similar to the PIIX4 and are part
>>      of Intel's '810' and other chipsets.
>> @@ -457,6 +458,7 @@
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_17) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_17) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_6) },
>>  	{ 0, }
>>  };
>>
>> --- linux-2.6.19-rc6/drivers/i2c/busses/Kconfig.orig	2006-11-22
>07:05:25.000000000 -0800
>> +++ linux-2.6.19-rc6/drivers/i2c/busses/Kconfig	2006-11-22
>07:05:36.000000000 -0800
>> @@ -125,6 +125,7 @@
>>  	    ICH7
>>  	    ESB2
>>  	    ICH8
>> +	    ICH9
>>
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called i2c-i801.
>
>Thanks,
>--
>Jean Delvare
