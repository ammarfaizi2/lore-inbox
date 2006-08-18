Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWHRNZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWHRNZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWHRNZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:25:16 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:27599 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751384AbWHRNZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:25:14 -0400
Message-ID: <44E5BFB7.4000400@de.ibm.com>
Date: Fri, 18 Aug 2006 15:25:11 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
References: <200608181331.19501.ossthema@de.ibm.com> <1155903451.4494.168.camel@laptopd505.fenrus.org>
In-Reply-To: <1155903451.4494.168.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> +	queue->queue_length = nr_of_pages * pagesize;
>> +	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
> 
> 
> wow... is this really so large that it warrants a vmalloc()???

Agreed: Replaced with kmalloc()

Regards
Thomas
