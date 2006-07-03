Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWGCNI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWGCNI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWGCNI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:08:29 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:13307 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751119AbWGCNI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:08:28 -0400
Message-ID: <44A916C5.90201@de.ibm.com>
Date: Mon, 03 Jul 2006 15:08:21 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Cedric Le Goater <clg@fr.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org> <44A90A62.8050202@fr.ibm.com> <20060703121732.GC9420@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060703121732.GC9420@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
>> the statistic infrastructure is required when compiling the ZFCP driver on
>> zSeries.
>> ---
>>  drivers/scsi/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> Index: 2.6.17-mm6/drivers/scsi/Kconfig
>> ===================================================================
>> --- 2.6.17-mm6.orig/drivers/scsi/Kconfig
>> +++ 2.6.17-mm6/drivers/scsi/Kconfig
>> @@ -2200,6 +2200,7 @@ config ZFCP
>>  	tristate "FCP host bus adapter driver for IBM eServer zSeries"
>>  	depends on S390 && QDIO && SCSI
>>  	select SCSI_FC_ATTRS
>> +	select STATISTICS
>>  	help
>>            If you want to access SCSI devices attached to your IBM eServer
>>            zSeries by means of Fibre Channel interfaces say Y.
> 
> That's the wrong approach. We rather need some no-op defines that make
> this compile for !CONFIG_STATISTICS. Martin is working on it, I think.

My fault, sorry.

Heiko is right.
I need to fix include/linux/statistic.h.
I will post the fix tonight.

Martin


