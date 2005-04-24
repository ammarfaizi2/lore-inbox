Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVDXQzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVDXQzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 12:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVDXQzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 12:55:25 -0400
Received: from 216-237-124-58.infortech.net ([216.237.124.58]:49306 "EHLO
	mail.dvmed.net") by vger.kernel.org with ESMTP id S262352AbVDXQzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 12:55:18 -0400
Message-ID: <426BCF6E.2000000@pobox.com>
Date: Sun, 24 Apr 2005 12:55:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tais M. Hansen" <tais.hansen@osd.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
References: <200504211941.43889.tais.hansen@osd.dk> <200504240008.58326.tais.hansen@osd.dk>
In-Reply-To: <200504240008.58326.tais.hansen@osd.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tais M. Hansen wrote:
> On Thursday 21 April 2005 19:41, Tais M. Hansen wrote:
> 
>>One of my linux boxes has a Plextor DVD-RW drive with a SATA interface. The
>>kernel sees this drive (ata3) but apparently doesn't tie it to a sdx
>>device. The box also have a SATA harddisk, which is working just fine. The
>>relevant dmesg output is pasted below.
> 
> 
> I've been digging through sr, scsi, sata_via, libata-scsi and libata-core, 
> littering the code with printk's.
> 
> My lack of knowledge on how the kernel handles devices, is really showing now. 
> 
> I've been unable to figure out what is supposed to tie sr to the devices 
> probed by sata_via. Also, littering sr with printk's gave me the idea that sr 
> is not even looking for cdrom devices. It loads, does the basic module __init 
> stuff and then silence. Should sr find devices itself or is the kernel 
> supposed to inform sr via some callback hook? I could really be barking up 
> the wrong tree here, and not even see it.
> 
> Enabling SCSI logging and kernel debug didn't really give me anything useful.


Did you turn on ATA_ENABLE_ATAPI in include/linux/libata.h?

	Jeff


