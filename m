Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWGCNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWGCNNF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGCNNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:13:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:38617 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751123AbWGCNNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:13:04 -0400
Message-ID: <44A917D8.6050304@fr.ibm.com>
Date: Mon, 03 Jul 2006 15:12:56 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Peschke <mp3@de.ibm.com>
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org> <44A90A62.8050202@fr.ibm.com> <20060703121732.GC9420@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060703121732.GC9420@osiris.boeblingen.de.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
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

yes, you're right.

My approach is the shortest path to fix this -mm6 :

statistics-infrastructure-exploitation-zfcp.patch

thanks,

C.


