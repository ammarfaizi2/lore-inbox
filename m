Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWHUJxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWHUJxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWHUJxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:53:35 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:44179 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751818AbWHUJxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:53:33 -0400
Message-ID: <44E9829B.7010503@de.ibm.com>
Date: Mon, 21 Aug 2006 11:53:31 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Alexey Dobriyan <adobriyan@gmail.com>,
       Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com>	<20060818140506.GC5201@martell.zuzino.mipt.ru>	<44E5DFA6.7040707@de.ibm.com> <20060818104547.5ad1352f@localhost.localdomain>
In-Reply-To: <20060818104547.5ad1352f@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Fri, 18 Aug 2006 17:41:26 +0200
> Thomas Klein <osstklei@de.ibm.com> wrote:
> 
>> Hi Alexey,
>>
>> first of all thanks a lot for the extensive review.
>>
>>
>> Alexey Dobriyan wrote:
>>>> +	u64 hret = H_HARDWARE;
>>> Useless assignment here and everywhere.
>>>
>> Initializing returncodes to errorstate is a cheap way to prevent
>> accidentally returning (uninitalized) success returncodes which
>> can lead to catastrophic misbehaviour.
> 
> That is old thinking. Current compilers do live/dead analysis
> and tell you about this at compile time which is better than relying
> on default behavior at runtime.

Understood. I reworked the returncode handling and removed the
unnecessary initializations.

Thanks for pointing this out.

Thomas
