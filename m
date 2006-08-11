Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWHKNmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWHKNmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHKNmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:42:42 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:39086 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751119AbWHKNmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:42:40 -0400
Message-ID: <44DC804B.70609@de.ibm.com>
Date: Fri, 11 Aug 2006 15:04:11 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com> <20060811000540.200CE67B6B@ozlabs.org>
In-Reply-To: <20060811000540.200CE67B6B@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>> +#define EHEA_EQE_SM_MECH_NUMBER  EHEA_BMASK_IBM(48, 55)
>> +#define EHEA_EQE_SM_PORT_NUMBER  EHEA_BMASK_IBM(56, 63)
>> +
>> +struct ehea_eqe {
>> +	u64 entry;
>> +};
> 
> ehea_ege.. what is that and why a struct if only 1 item?  Comments
> please.  
> 

There are send / receive queue elements (ehea_swqe, ehea_rwqe),
completion queue elements (ehea_cqe) and event queue elements (ehea_eqe).
We introduced struct ehea_eqe to get a consistent description for all
queue elements.

Jan-Bernd

