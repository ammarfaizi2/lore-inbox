Return-Path: <linux-kernel-owner+w=401wt.eu-S932371AbXAIVtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXAIVtH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXAIVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:49:07 -0500
Received: from mga06.intel.com ([134.134.136.21]:9009 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371AbXAIVtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:49:06 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 16:49:06 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="183263870:sNHT33833233"
Message-ID: <45A40B83.2060009@foo-projects.org>
Date: Tue, 09 Jan 2007 13:39:15 -0800
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A4003A.3080403@wolfmountaingroup.com>
In-Reply-To: <45A4003A.3080403@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 21:39:15.0514 (UTC) FILETIME=[9C1971A0:01C73436]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Jeff V. Merkey wrote:
> 
> root=/dev/hda2 is what was passed to the kernel from grub.
> 
> Jeff
> 
>>
>> I just finished pulling out a melted IDE flash drive out of a Shuttle 
>> motherboard with the intel 945 chipset which claims to support
>> SATA and IDE drives concurrently under Linux 2.6.18.
>>
>> The chip worked for about 30 seconds before liquifying in the 
>> chassis.  I note that the 945 chipset in the shuttle PC had some serious
>> issues recognizing 2 x SATA devices and a IDE device concurrently.   
>> Are there known problems with the Linux drivers
>> with these newer chipsets.
>>
>> One other disturbing issue was the IDE flash drive was configured (and 
>> recognized) as /dev/hda during bootup, but when
>> it got to the root mountint, even with root=/dev/hda set, it still 
>> kept thinking the drive was at scsi (ATA) device (08,13)
>> and kept crashing with VFS cannot find root FS errors.

it sounds like someone switched the BIOS IDE setting from ide-compatible/legacy to AHCI 
or similar, a not uncommon option in the sata controllers on those boards.

None of that would explain the melting of anything of course.

Cheers,

Auke
