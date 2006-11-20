Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934249AbWKTPpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934249AbWKTPpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934250AbWKTPpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:45:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:54319 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S934253AbWKTPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:45:28 -0500
Message-ID: <4561CCA6.8080209@oracle.com>
Date: Mon, 20 Nov 2006 07:41:26 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Chris Snook <csnook@redhat.com>
CC: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] atl1: Build files for Attansic L1 driver
References: <20061119202915.GB29736@osprey.hogchain.net> <20061119152432.a85d4166.randy.dunlap@oracle.com> <456145DA.804@redhat.com>
In-Reply-To: <456145DA.804@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Snook wrote:
> Randy Dunlap wrote:
>> On Sun, 19 Nov 2006 14:29:15 -0600 Jay Cliburn wrote:
>>
>>> From: Jay Cliburn <jacliburn@bellsouth.net>
>>>
>>> This patch contains the build files for the Attansic L1 gigabit ethernet
>>> adapter driver.
>>>
>>> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
>>> ---
>>>
>>>  Kconfig       |   12 ++++++++++++
>>>  Makefile      |    1 +
>>>  atl1/Makefile |   30 ++++++++++++++++++++++++++++++
>>>  3 files changed, 43 insertions(+)
>>>
>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>> index 6e863aa..f503d10 100644
>>> --- a/drivers/net/Kconfig
>>> +++ b/drivers/net/Kconfig
>>> @@ -2329,6 +2329,18 @@ config QLA3XXX
>>>        To compile this driver as a module, choose M here: the module
>>>        will be called qla3xxx.
>>>  
>>> +config ATL1
>>> +    tristate "Attansic(R) L1 Gigabit Ethernet support (EXPERIMENTAL)"
>>> +    depends on NET_PCI && PCI && EXPERIMENTAL
>>> +    select CRC32
>>> +    select MII
>>> +    ---help---
>>> +      This driver supports Attansic L1 gigabit ethernet adapter.
>>> +
>>> +      To compile this driver as a module, choose M here.  The module
>>> +      will be called atl1.
>>> +
>>> +
>>>  endmenu
>>
>> One problem here is that MII depends on NET_ETHERNET, which is
>> 10/100 ethernet, which may not be enabled if someone has only
>> gigabit ethernet.  :)
> 
> I'm actually quite inclined to rip out all MII support entirely. There's 
> a lot of code in this driver that needs cleaning up cosmetically, and 
> removing deprecated features would certainly speed things up.  What do 
> you think?

All of that sounds like a good idea to me.
I didn't realize that MII support is deprecated.  Do you mean
that it's deprecated for gigabit?

-- 
~Randy
