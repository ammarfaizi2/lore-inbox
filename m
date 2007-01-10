Return-Path: <linux-kernel-owner+w=401wt.eu-S932432AbXAJAiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbXAJAiZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbXAJAiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:38:25 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:33935 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432AbXAJAiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:38:24 -0500
Message-ID: <45A42FA2.2070106@wolfmountaingroup.com>
Date: Tue, 09 Jan 2007 17:13:22 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A42385.7090904@garzik.org> <45A42670.703@wolfmountaingroup.com> <45A4325C.9060902@garzik.org>
In-Reply-To: <45A4325C.9060902@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Jeff V. Merkey wrote:
>
>> Jeff Garzik wrote:
>>
>>> Jeff V. Merkey wrote:
>>>
>>>>
>>>> I just finished pulling out a melted IDE flash drive out of a 
>>>> Shuttle motherboard with the intel 945 chipset which claims to support
>>>> SATA and IDE drives concurrently under Linux 2.6.18.
>>>>
>>>> The chip worked for about 30 seconds before liquifying in the 
>>>> chassis.  I note that the 945 chipset in the shuttle PC had some 
>>>> serious
>>>> issues recognizing 2 x SATA devices and a IDE device 
>>>> concurrently.   Are there known problems with the Linux drivers
>>>> with these newer chipsets.
>>>>
>>>> One other disturbing issue was the IDE flash drive was configured 
>>>> (and recognized) as /dev/hda during bootup, but when
>>>> it got to the root mountint, even with root=/dev/hda set, it still 
>>>> kept thinking the drive was at scsi (ATA) device (08,13)
>>>> and kept crashing with VFS cannot find root FS errors.
>>>
>>>
>>>
>>> We have two sets of ATA drivers now, and Intel motherboards support 
>>> bazillion annoying IDE modes, so you will need to provide more info 
>>> than this.
>>>
>>> Is the motherboard in combined mode?
>>
>>
>>
>> Yes.  "Enhanced mode" is how it is listed in the BIOS.
>
>
> Combined mode is a technical term.  Judging from your answers, you are 
> not using combined mode.
>
>
>>> native mode?  AHCI or RAID mode?
>>
>>
>> No RAID, just enhanced mode (SATA 3.0 + IDE)
>
>
> Judging from your answers, you are not in AHCI mode.
>
> Side note:  You should use AHCI if available.  Emulating a PATA 
> interface for SATA devices is error prone [in the silicon].  AHCI is 
> native SATA, "enhanced mode" is not.


AHCI It is.   

Jeff

>
>
>>> The cannot-find-root-FS errors are definitely caused by driver 
>>> and/or initrd misconfiguration.  The melted flash, I dunno, maybe 
>>> you managed to get two drivers fighting over the same hardware.
>>
>>
>> No.  Seems related to the chipset problems.  If I say 
>> "root=/dev/hda2" I have better not be getting errors claiming device 
>> 08:13 could not mount as root.  memory corruption?
>
>
> If the kernel cannot mount the requested root= disk, it tries the 
> default that is encoded into the vmlinuz image at build time, which is 
> probably 08:13.
>
>
>> The melted flash seems power related (like pin 20 was live for some 
>> reason on a standard IDE).
>
>
> Probably, otherwise we would have many more reports like this than 
> just yours.
>
>     Jeff
>
>
>

