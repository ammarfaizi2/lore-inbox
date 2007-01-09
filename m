Return-Path: <linux-kernel-owner+w=401wt.eu-S932482AbXAIXVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbXAIXVo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXAIXVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:21:43 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:38685 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbXAIXVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:21:43 -0500
Message-ID: <45A42385.7090904@garzik.org>
Date: Tue, 09 Jan 2007 18:21:41 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com>
In-Reply-To: <45A3FF32.1030905@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> 
> I just finished pulling out a melted IDE flash drive out of a Shuttle 
> motherboard with the intel 945 chipset which claims to support
> SATA and IDE drives concurrently under Linux 2.6.18.
> 
> The chip worked for about 30 seconds before liquifying in the chassis.  
> I note that the 945 chipset in the shuttle PC had some serious
> issues recognizing 2 x SATA devices and a IDE device concurrently.   Are 
> there known problems with the Linux drivers
> with these newer chipsets.
> 
> One other disturbing issue was the IDE flash drive was configured (and 
> recognized) as /dev/hda during bootup, but when
> it got to the root mountint, even with root=/dev/hda set, it still kept 
> thinking the drive was at scsi (ATA) device (08,13)
> and kept crashing with VFS cannot find root FS errors.

We have two sets of ATA drivers now, and Intel motherboards support 
bazillion annoying IDE modes, so you will need to provide more info than 
this.

Is the motherboard in combined mode?  native mode?  AHCI or RAID mode?
What driver set did you pick?  is drivers/ide built in, modular, or 
disabled?  is drivers/ata built in, modular, or disabled?

The cannot-find-root-FS errors are definitely caused by driver and/or 
initrd misconfiguration.  The melted flash, I dunno, maybe you managed 
to get two drivers fighting over the same hardware.

	Jeff



