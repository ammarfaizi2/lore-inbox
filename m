Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUEQTLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUEQTLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUEQTLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:11:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47254 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262215AbUEQTK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:10:56 -0400
Message-ID: <40A90E31.7060203@pobox.com>
Date: Mon, 17 May 2004 15:10:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Robert Fendt <fendt@physik.uni-dortmund.de>, linux-kernel@vger.kernel.org,
       James P Ketrenos <james.p.ketrenos@intel.com>
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>	 <1084584998.12352.306.camel@dhcppc4>	 <20040517123011.7e12d297.fendt@physik.uni-dortmund.de> <1084818282.12349.334.camel@dhcppc4>
In-Reply-To: <1084818282.12349.334.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Mon, 2004-05-17 at 06:30, Robert Fendt wrote:
> 
>>On 14 May 2004 21:36:38 -0400
>>Len Brown <len.brown@intel.com> wrote:
>>
>>
>>>If the 8139too has statistics counters showing if it gets
>>>RX buffer over-runs, that would be interseting to observe.
>>
> 
>>a) with 'processor' loaded
>>
>>robert@betazed:~$ wget http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
>>--12:27:16--  http://download.sourcemage.org/iso/smgl-i386-2.6.5-20040414.iso.bz2
>>           => `smgl-i386-2.6.5-20040414.iso.bz2'
>>Resolving download.sourcemage.org... 152.2.210.81
>>Connecting to download.sourcemage.org[152.2.210.81]:80... connected.
>>HTTP request sent, awaiting response... 200 OK
>>Length: 142,065,569 [text/plain]
>>
>> 0% [                                     ] 202,609        2.30K/s ETA 10:17:41
>>
>>
>>robert@betazed:~$ /sbin/ifconfig
>>eth0      Link encap:Ethernet  HWaddr 00:0C:6E:8A:DD:BA  
>>          inet addr:129.217.168.125  Bcast:129.217.168.255  Mask:255.255.255.0
>>          inet6 addr: fe80::20c:6eff:fe8a:ddba/64 Scope:Link
>>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>>          RX packets:933 errors:117 dropped:212 overruns:117 frame:0
> 
> 
> BINGO
> 
> There may be a way to get more detailed stats out of the driver with
> netstat or something, Jeff would know.


Almost all the standard stats are listed in /proc/net/dev...  8139 
hardware doesn't have any NIC-specific stats besides the Rx-Missed 
counter either, IIRC.

	Jeff



