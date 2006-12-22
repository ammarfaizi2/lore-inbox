Return-Path: <linux-kernel-owner+w=401wt.eu-S1945960AbWLVHSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945960AbWLVHSS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbWLVHSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:18:18 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:24981 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945956AbWLVHSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:18:17 -0500
Message-ID: <458B86A7.6030402@chelsio.com>
Date: Thu, 21 Dec 2006 23:17:59 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Divy Le Ray <None@chelsio.com>, jeff@garzik.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
Subject: Re: [PATCH 2/10] cxgb3 - main source file
References: <20061220124134.6299.29373.stgit@localhost.localdomain>	 <1166623330.3365.1397.camel@laptopd505.fenrus.org>	 <4589CA9C.80007@chelsio.com> <1166688978.3365.1472.camel@laptopd505.fenrus.org>
In-Reply-To: <1166688978.3365.1472.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Dec 2006 07:18:02.0515 (UTC) FILETIME=[51280630:01C72599]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> They are used to parameter the HW:
>> register access,
>
> ethtool supports that, so shouldn't be an ioctl for sure
>
>>  configuration of queue sets, on board memory 
>> configuration,
>
> I'm sure ethtool can do that too
>
>> firmware load, etc ...
>
> and for this we have request_firmware() interface. 
>
> adding device specific ioctl that duplicate functionality that exists or
> should exist in a generic way isn't really acceptable for 2.6 kernels
> anymore....
>
Arjan,

The driver implements all the ethtool operations that apply to it.
The GETREG ioctl is left for debug purposes:
get_regs doesn't return clear-on-read registers while GETREG does.

Using request_firmware assumes that the driver knows the FW file name
and the driver initiates the load. That's not our model where we work
with different FWs, don't know what the names are, and the user 
initiates the load.

Cheers,
Divy
