Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291377AbSBGWaH>; Thu, 7 Feb 2002 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291378AbSBGW3s>; Thu, 7 Feb 2002 17:29:48 -0500
Received: from urdvg001.cms.usa.net ([165.212.11.1]:6319 "HELO
	urdvg001.cms.usa.net") by vger.kernel.org with SMTP
	id <S291377AbSBGW3f>; Thu, 7 Feb 2002 17:29:35 -0500
Message-ID: <3C62FE47.6020708@sundanceti.com>
Date: Thu, 07 Feb 2002 14:23:03 -0800
From: Craig Rich <craig_rich@sundanceti.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Scatter Gather List Questions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff:

	Hello. Saw this post on the Internet, and was hoping you are still open 
to answering some questions about scatter/gather lists in Linux.

	I'm tyring to update the Linux driver for our triple speed Ethernet MAC 
(we haven't formally given the driver to you yet; I guess we should soon.)

	Anyhow, I'm trying to find documentation, or examples of how to use the 
scatter/gather capabilities of Linux, and not having much luck. So 
basically, I'm not sure where to start. I tried grepping the source as 
you say below, its not helping much.

	One question I can start with is, how do you use pci_dma_sg?

pci_map_sg(dev, sglist, nents, direction);

	I'm assuming I supply the dev and direction fields. How about the nents 
field? Is that supposed to be the largest number of fragments I can 
handle (that's what I assumed.) Finally, the sglist argument has me 
really confused. Do I have to create this structure in advance (and if 
so how) or is pci_map_sg supposed to simply give me a pointer back via 
the sglist argument (that's what I assumed, but that doesn't seem to be 
the case unless I'm doing something else wrong.)

	Also, were in the source code is pci_map_sg located? I'll admit I'm not 
an expert at looking through the source code of an OS like Linux, but 
I'm frustrated by the fact that a simple grep of /usr/src/linux-2.4.2 
does not show where this function is coded.

	Any help would be greatly appreciated.

> Jeff Garzik  linux-kernel@vger.kernel.org
> Wed, 14 Nov 2001 20:41:34 -0500
> 
>     * Previous message: [linux-kernel] Need Info on Checksum Offloading
>     * Next message: [linux-kernel] tty stuff
>     * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
> 
> harish.vasudeva@amd.com wrote:
>> > Hi All,
>> > Could any1 pls direct me wherein i could find some documentation about implementing checksum offloading for my ethernet LAN driver?
> 
> 
> There is not good documentation.  Feel free to ask me questions, I am
> the Linux network driver maintainer.
> 
> First, search the source code in linux/drivers/net/* for
> NETIF_F_IP_CSUM, NETIF_F_HW_CSUM, skb->csum, and nr_frags.
> 
> Can I expect an ethernet driver submitted to me, soon?
> 
> 	Jeff
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
> 


-- 
Craig Rich
Senior Systems Engineer         mailto:craig_rich@sundanceti.com
Sundance Technology Inc.        http://www.sundanceti.com
1485 Saratoga Avenue            tel: 408 873 4117 x107
Suite 200                       fax: 408 996 7064
San Jose, CA, USA  95129

