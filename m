Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319196AbSHTQ65>; Tue, 20 Aug 2002 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319197AbSHTQ65>; Tue, 20 Aug 2002 12:58:57 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:16852 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S319196AbSHTQ64>; Tue, 20 Aug 2002 12:58:56 -0400
Message-ID: <3D627641.4040301@cox.net>
Date: Tue, 20 Aug 2002 10:02:57 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1b) Gecko/20020721
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stanislav Brabec <utx@penguin.cz>
CC: Andre Hedrick <andre@linux-ide.org>, Paul Bristow <paul@paulbristow.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty
References: <Pine.LNX.4.10.10208191744570.458-100000@master.linux-ide.org> <3D619776.7010104@cox.net> <20020820110910.GB2831@utx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is present on all devices supported by the ide-floppy 
driver. It won't be fixed until the ide-probe patch makes it into the 
official kernel. At that point the /dev/discs/... entry for the drive 
will appear at boot time even without media present in the drive.

However, without my other media change handling patches, the partition 
entries inside the /dev/discs/... directory for the floppy drive will 
not stay in sync terribly well when you make media changes.

Stanislav Brabec wrote:
> Stanislav Brabec wrote:
> 
>>If module ide-floppy is loaded and no disc is present in the drive,
>>/dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
>>inserted media cannot be checked in any way, because no /dev entry
>>exists.
>>
> 
> Kevin P. Fleming wrote:
> 
>>diff -X dontdiff -urN linux/drivers/ide/ide-probe.c
>>linux-probe/drivers/ide/ide-probe.c
> 
> 
> Does anybody know, whether this problem was present on LS-120/240,
> IOMEGA PocketZip and JAZ devices and is fixed now?
> 

