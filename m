Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310120AbSCLBuu>; Mon, 11 Mar 2002 20:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310330AbSCLBub>; Mon, 11 Mar 2002 20:50:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310120AbSCLBuY>;
	Mon, 11 Mar 2002 20:50:24 -0500
Message-ID: <3C8D5ECD.6090108@mandrakesoft.com>
Date: Mon, 11 Mar 2002 20:50:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: andersen@codepoet.org, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111736520.8121-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
>>Your first question is really philosophical.  I think that people should
>>-not- be able to send undocumented commands through the interface...
>> and in this area IMO it pays to be paranoid.
>>
>
>What if the command is perfectly documented, but only for a certain class
>of IBM disks?
>
>Are you going to create a table of every disk out there, along with every
>command it can do?
>
>Remember: the kernel driver is a driver for the host controller, yet the
>command is for the _disk_. It makes no sense to check for disk commands in
>a host controller driver - they are two different things.
>
>It's like checking for icmp messages in a network driver. Do you seriously
>propose having network drivers check icmp messages for command validity?
>
See my other message, and thanks for making this analogy :)

I -do- know the distrinction between hosts and devices.  I think there 
should be -some- way, I don't care how, to filter out those unknown 
commands (which may be perfectly valid for a small subset of special IBM 
drives).  The net stack lets me do filtering, I want to sell you on the 
idea of letting the ATA stack do the same thing.

You have convinced me that unconditional filtering is bad.  But I still 
think people should be provided the option to filter if they so desire.

    Jeff





