Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWFPVUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWFPVUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 17:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWFPVUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 17:20:36 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:57558 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S1751449AbWFPVUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 17:20:35 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: "Michael Chan" <mchan@broadcom.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: tg3 timeouts with 2.6.17-rc6
References: <1551EAE59135BE47B544934E30FC4FC041BD16@NT-IRVA-0751.brcm.ad.broadcom.com>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: "Michael Chan" <mchan@broadcom.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Fri, 16 Jun 2006 23:20:30 +0200
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC041BD16@NT-IRVA-0751.brcm.ad.broadcom.com>
	(Michael Chan's message of "Fri, 16 Jun 2006 10:02:32 -0700")
Message-ID: <87k67glrvl.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Chan <mchan@broadcom.com> writes:

> Juergen Kreileder
>
>> I'm seeing frequent network timeouts on my PowerMac G5 Quad with
>> 2.6.17-rc6.  The timeouts are easily reproducible with moderate
>> network traffic, e.g. by using bittorrent.
>>
>
> Did this use to work with an older kernel or older tg3 driver? If
> yes, what version?

Works fine with 2.6.16 and earlier.

> Please also provide the full tg3 probing output during modprobe and
> ifconfig up. Thanks.

,----
| tg3.c:v3.58 (May 22, 2006)
| eth0: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:51:66:ff:b2
| eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
| eth0: dma_rwctrl[76144000] dma_mask[40-bit]
| eth1: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:51:66:ff:b3
| eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
| eth1: dma_rwctrl[76144000] dma_mask[40-bit]
| [...]
| tg3: lan0: Link is up at 1000 Mbps, full duplex.
| tg3: lan0: Flow control is on for TX and on for RX.
`----

eth0 and eth1 get renamed to lan0 and lan1 by udev.  eth0/lan0 is
connected to a Gigabit switch eth1/lan1 is not connected.
Both interface are controlled by ifplugd (using SIOCETHTOOL for link
beat detection).

Let me know if you need more debugging output.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
