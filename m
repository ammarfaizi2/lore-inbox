Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWHRPlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWHRPlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWHRPlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:41:31 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:33216 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161029AbWHRPl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:41:29 -0400
Message-ID: <44E5DFA6.7040707@de.ibm.com>
Date: Fri, 18 Aug 2006 17:41:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com> <20060818140506.GC5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818140506.GC5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

first of all thanks a lot for the extensive review.


Alexey Dobriyan wrote:
>> +	u64 hret = H_HARDWARE;
> 
> Useless assignment here and everywhere.
> 

Initializing returncodes to errorstate is a cheap way to prevent
accidentally returning (uninitalized) success returncodes which
can lead to catastrophic misbehaviour.

>> +static void netdev_get_drvinfo(struct net_device *dev,
>> +			       struct ethtool_drvinfo *info)
>> +{
>> +	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
>> +	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
> 
> Use strlcpy() to not forget -1 accidently.

I agree.

Kind regards
Thomas
