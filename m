Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUIOVF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUIOVF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUIOVF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:05:26 -0400
Received: from main.gmane.org ([80.91.229.2]:11210 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267519AbUIOVEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:04:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: The ultimate TOE design
Date: Wed, 15 Sep 2004 16:03:57 -0500
Message-ID: <ciaao4$crc$1@sea.gmane.org>
References: <4148991B.9050200@pobox.com> <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <4148A561.5070401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
In-Reply-To: <4148A561.5070401@redhat.com>
Cc: netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> Paul Jakma wrote:
> 
>> On Wed, 15 Sep 2004, Jeff Garzik wrote:
>>
>>> Put simply, the "ultimate TOE card" would be a card with network 
>>> ports, a generic CPU (arm, mips, whatever.), some RAM, and some 
>>> flash.  This card's "firmware" is the Linux kernel, configured to run 
>>> as a _totally indepenent network node_, with IP address(es) all its own.
>>>
>>> Then, your host system OS will communicate with the Linux kernel 
>>> running on the card across the PCI bus, using IP packets (64K fixed 
>>> MTU).

>> The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI 
>> card running Linux. Or is that what you were referring to with "<cards 
>> exist> but they are all fairly expensive."?

> IBM's PowerNP chip was also very simmilar (a powerpc core with lots of 
> hardware assists for DMA and packet inspection in the extended register 
> area).  Don't know if they still sell it, but at one time I had heard 
> they had booted linux on it.

An IXP or PowerNP wouldn't work for Jeff's idea. The IXP's XScale core 
and PowerNP's PowerPC core are way too slow to do any significant 
processing; they are intended for control tasks like updating the 
routing tables. All the work in the IXP or PowerNP is done by the 
microengines, which have weird, non-Linux-compatible architectures.

To do 10 Gbps Ethernet with Jeff's approach, wouldn't you need a 5-10 
GHz processor on the card? Sounds expensive.

A 440GX or BCM1250 on a cheap PCI card would be fun to play with, though.

Wes Felter - wesley@felter.org - http://felter.org/wesley/

