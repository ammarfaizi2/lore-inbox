Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWHJPM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWHJPM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWHJPM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:12:59 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:32041 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751263AbWHJPM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:12:58 -0400
Message-ID: <44DB4CF7.9080905@de.ibm.com>
Date: Thu, 10 Aug 2006 17:12:55 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
CC: linuxppc-dev@ozlabs.org, Jan-Bernd Themann <ossthema@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
References: <44D99F1A.4080905@de.ibm.com> <200608091514.46861.arnd.bergmann@de.ibm.com>
In-Reply-To: <200608091514.46861.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Wednesday 09 August 2006 10:38, Jan-Bernd Themann wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_hcall.h 1969-12-31 16:00:00.000000000 -0800
>> +++ kernel/drivers/net/ehea/ehea_hcall.h        2006-08-08 23:59:38.111462960 -0700
>> @@ -0,0 +1,52 @@
>
>> +
>> +/**
>> + * This file contains HCALL defines that are to be included in the appropriate
>> + * kernel files later
>> + */
>> +
>> +#define H_ALLOC_HEA_RESOURCE   0x278
>> +#define H_MODIFY_HEA_QP        0x250
>> +#define H_QUERY_HEA_QP         0x254
>> +#define H_QUERY_HEA            0x258
>> +#define H_QUERY_HEA_PORT       0x25C
>> +#define H_MODIFY_HEA_PORT      0x260
>> +#define H_REG_BCMC             0x264
>> +#define H_DEREG_BCMC           0x268
>> +#define H_REGISTER_HEA_RPAGES  0x26C
>> +#define H_DISABLE_AND_GET_HEA  0x270
>> +#define H_GET_HEA_INFO         0x274
>> +#define H_ADD_CONN             0x284
>> +#define H_DEL_CONN             0x288
>
> I  guess these should go to include/asm-powerpc/hvcall.h instead.
>
>       Arnd <><

We posted a separate patch for hvcall.h (http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025000.html).
As soon as this patch is accepted we'll remove the ehea_hcall.h headerfile.


