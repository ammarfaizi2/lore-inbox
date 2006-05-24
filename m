Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWEXXQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWEXXQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEXXQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:16:05 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33673 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932303AbWEXXQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:16:04 -0400
Date: Wed, 24 May 2006 17:15:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Q: how to send ATA cmds to USB drive?
In-reply-to: <6fXQT-16z-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: robomod@news.nic.it
Message-id: <4474E92E.8020403@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6fXQT-16z-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:
> good day,
> 
> I have a question concerning sending arbitrary ATA commands to an USB
> drive.
> 
> Currently, I have a particular application which sends special ATA commands
> to an IDE drive using IDE_TASKFILE. So far, this works pretty well.
> 
> But now I also have to support USB harddisks from the same company.
> The USB harddisk uses the same set of ATA commands as the IDE harddisk,
> well, at least that's what I suppose.
> 
> How do I send ATA commands to this USB drive? I suppose this would be
> done via SG_IO (the drive is recognised by linux as usb-storage, of
> course), but how exactly does this have to be done? I have already
> used SG_IO before to send some MMC commands to cdvd-drives, but I
> don't know how to send ATA (such as those from T13) commands with this
> interface.

Short answer is you likely can't. The USB-to-IDE bridge pretty much 
entirely hides the fact that it's an IDE drive behind it, from the 
host's viewpoint it looks pretty much like SCSI. Maybe if you sent SCSI 
commands to the device it would translate them into the correct ATA 
commands, depending on what exactly you're doing, but that's entirely 
dependent on the bridge chip in question and I would guess most of them 
don't support such fancy operations.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

