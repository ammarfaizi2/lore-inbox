Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWADVnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWADVnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbWADVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:43:19 -0500
Received: from imo-m14.mx.aol.com ([64.12.138.204]:31204 "EHLO
	imo-m14.mx.aol.com") by vger.kernel.org with ESMTP id S1751233AbWADVnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:43:18 -0500
Message-ID: <43BC4161.1030800@aol.com>
Date: Wed, 04 Jan 2006 16:42:57 -0500
From: andy liebman <andyliebman@aol.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: rdunlap@xenotime.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Atapi CDROM, SATA OS drive, and 2.6.14+ kernel
References: <8C7DF7FCD8430A9-C8C-4BB2@MBLK-M38.sysops.aol.com> <Pine.LNX.4.58.0601041224180.19134@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0601041224180.19134@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 146.115.27.35
X-Mailer: Unknown (No Version)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rdunlap@xenotime.net wrote:
> On Wed, 4 Jan 2006 andyliebman@aol.com wrote:
> 
>> Can somebody tell me what changed in the 2.6.14 kernel that doesn't
>> allow me to access my CDROM drive when my OS drive is SATA?
>>
>> I have an image of a working 2.6.14 system that was installed on an IDE
>> drive. I restored the image to a SATA drive, changed a few lines in
>> /etc/fstab and /etc/lilo.conf so that they refer to /dev/sd* devices
>> instead of /dev/hd* devices.
>>
>> I also modified /etc/modprobe.conf so that it is identical to the file
>> that Mandriva 2006 produces when installed directly to a SATA drive
>> (but Mandriva 2006 has the 2.6.12.x kernel).
>>
>> I can't mount my CDROM when running 2.6.14.x
>>
>> I have googled this for several days. I have seen posts about passing
>> options to the kernel and including extra lines in modprobe.conf like:
>>
>> libata atapi_enabled=1
> 
> should be:
>   libata.atapi_enabled=1
> if libata is built into the kernel image.

Well, I added that to my modprobe.conf file, remade the initrd. But then 
on rebooting I got a kernel panic -- VFS not able to sync root filesystem.

Any other ideas?

> 
>> Can't find the magic formula. Help would be appreciated.
> 

