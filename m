Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWEMI0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWEMI0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWEMI0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 04:26:24 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:34029
	"EHLO bifrost.lang.hm") by vger.kernel.org with ESMTP
	id S1750985AbWEMI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 04:26:23 -0400
Date: Sat, 13 May 2006 01:26:16 -0700 (PDT)
From: David Lang <david@lang.hm>
X-X-Sender: dlang@david.lang.hm
To: Roger Luethi <rl@hellgate.ch>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: network freeze with nforce-A939 integrated rhine card
In-Reply-To: <Pine.LNX.4.62.0605122209330.2803@qnivq.ynat.uz>
Message-ID: <Pine.LNX.4.62.0605130122310.2801@qnivq.ynat.uz>
References: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
 <20060512214109.GD2274@k3.hellgate.ch> <Pine.LNX.4.62.0605122209330.2803@qnivq.ynat.uz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006, David Lang wrote:

> On Fri, 12 May 2006, Roger Luethi wrote:
>
>> On Thu, 11 May 2006 22:59:44 -0700, David Lang wrote:
>>> I haven't had time to go back and find where is started (my prior kernel
>>> was 2.6.15-rc7), but with 2.6.17-rc1/2/3/4 I've been running into a
>>> problem where when transfering large amounts of data (trying to ftp a TB
>> 
>> "where is started" sounds as if it used to work at some point. In your
>> second posting, however, you note that the problem goes back at least to
>> 2.6.13. So are there any kernels known not to exhibit the problem you
>> described?
>
> when I posted this origionally I thought it was new in 2.6.17-rc, however 
> since my testing with older kernels hasn't found me a working one yet I 
> suspect that other factors have been involved with makeing it work.
>
> these failures have been on multi-gig files ftp'd from the raid array on my 
> machine to the raid array on the replacement machine. In the past I've 
> sucessfully transfered similar sized files to/from my tivo (slow network), my 
> laptop (slow drive), and smaller sets of files to single drives on other 
> systems (7200rpm drives, but not to arrays).
>
> as I type this I'm starting a test going from a single drive on this machine 
> to the raid array on the remote machine to transfer ~84G of data. My 
> suspicion is that this is going to work.

I just confirmed this, I was able to transfer 84G with no trouble starting 
from /dev/hdb, but starting from /dev/md0 the nic hung in less then 3G

a good boot logs
eth0: VIA Rhine II at 0xe8121000, 00:11:5b:f4:14:a3, IRQ 17.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link cde1.

root@david:~# ethtool eth0
Settings for eth0:
         Supported ports: [ TP MII ]
         Supported link modes:   10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Supports auto-negotiation: Yes
         Advertised link modes:  10baseT/Half 10baseT/Full
                                 100baseT/Half 100baseT/Full
         Advertised auto-negotiation: Yes
         Speed: 100Mb/s
         Duplex: Full
         Port: MII
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: pumbg
         Wake-on: d
         Current message level: 0x00000001 (1)
         Link detected: yes

David Lang
