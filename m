Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031451AbWKVBa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031451AbWKVBa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966996AbWKVBa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:30:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:54077 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966922AbWKVBaz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:30:55 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,445,1157353200"; 
   d="scan'208"; a="18586184:sNHT22016601"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for Intel ICH9
Date: Tue, 21 Nov 2006 17:30:52 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07A5A356@orsmsx420.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch for Intel ICH9
Thread-Index: AccN1Lool5YJqzTFTMGTc9OPrCegMAAABt4Q
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Tejun Heo" <htejun@gmail.com>
Cc: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Nov 2006 01:30:53.0764 (UTC) FILETIME=[D9DC5840:01C70DD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking that if a functional difference was found, it would be
easier to tweak.

There are differences between the ICH8 and ICH9 SATA controller.  For
example, the PCS register now has port present bits that used to be
reserved in ICH8.  I'm not sure how or if these could be used in
ata_piix.

Jason



>-----Original Message-----
>From: Tejun Heo [mailto:htejun@gmail.com]
>Sent: Tuesday, November 21, 2006 5:23 PM
>To: Gaston, Jason D
>Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH 2.6.19-rc6][RESEND] ata_piix: IDE mode SATA patch
for
>Intel ICH9
>
>Jason Gaston wrote:
>> This patch adds the Intel ICH9 IDE mode SATA controller DID's.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>>
>> --- linux-2.6.19-rc6/drivers/ata/ata_piix.c.orig	2006-11-20
>04:58:48.000000000 -0800
>> +++ linux-2.6.19-rc6/drivers/ata/ata_piix.c	2006-11-20
>06:15:12.000000000 -0800
>
>Yeap, it came through fine this time, but ich8 and ich9 are identical
>from ata_piix's point of view.  Don't add ich9_sata_ahci, just use
>ich8_sata_ahci.
>
>--
>tejun
