Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTIOT4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTIOT4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:56:10 -0400
Received: from mrout3.yahoo.com ([216.145.54.173]:1287 "EHLO mrout3.yahoo.com")
	by vger.kernel.org with ESMTP id S261508AbTIOT4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:56:07 -0400
Message-ID: <3F661941.3010402@bigfoot.com>
Date: Mon, 15 Sep 2003 12:55:45 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SOLVED Re: intel D865PERL and DMA for disks (IDE)?
References: <3F62628B.5060805@bigfoot.com> <200309130236.14814.bzolnier@elka.pw.edu.pl> <3F626BA9.7040604@bigfoot.com>
In-Reply-To: <3F626BA9.7040604@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> On Saturday 13 of September 2003 02:19, Erik Steffl wrote:
> 
> ... Intel D965PERL and hdparm -d 1 ...
> 
>>> CONFIG_BLK_DEV_PIIX=m
>>> CONFIG_SCSI_ATA_PIIX=y
>>
>> You should use CONFIG_BLK_DEV_PIIX=y
>> or load piix module (may not be reliable).
> 
>   wow:
> 
> jojda:/home/erik# modprobe piix
> Segmentation fault
> 
>   lsmod | grep piix
> 
> piix                    7976   1  (initializing)
> 
>   rmmod piix
> 
> piix: Device or resource busy
> 
>   I guess I'll try to compile it in. thanks,

   in addition to the above it _seems_ that trying to modprobe piix 
caused netstat -ni to freeze (and so e.g. mozilla and evolution stopped 
working, but not konqueror, pan ...)

   I changed CONFIG_BLK_DEV_PIIX to y and it's working fine, so far (ide 
disks use dma).

	erik

