Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSGLO7v>; Fri, 12 Jul 2002 10:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSGLO7u>; Fri, 12 Jul 2002 10:59:50 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:8688 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id <S316586AbSGLO7t>;
	Fri, 12 Jul 2002 10:59:49 -0400
Message-ID: <3D2EEF88.2070609@cox.net>
Date: Fri, 12 Jul 2002 08:02:32 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1a) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <agl7ov$p91$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had plans for a while to add Media Status Notification to the 
ide-floppy driver, so it can do more intelligent media change 
management. To do so requires ATA (NOT ATAPI) commands to be issued to 
the drive(s). How would this work if ide-scsi is being used to talk to 
the drives? Would ide-scsi have to be taught about removable media and 
Media Status Notification?

H. Peter Anvin wrote:
> Okay, I have suggested this before, and I haven't quite looked at this
> in detail, but I would again like to consider the following,
> especially given the changes in 2.5:
> 
> Please consider deprecating or removing ide-floppy/ide-tape/ide-cdrom
> and treat all ATAPI devices as what they really are -- SCSI over IDE.
> It is a source of no ending confusion that a Linux system will not
> write CDs to an IDE CD-writer out of the box, for the simple reason
> that cdrecord needs access to the generic packet interface, which is
> only available in the nonstandard ide-scsi configuration.
> 
> There really seems to be no decent reason to treat ATAPI devices as
> anything else.  I understand the ide-* drivers contain some
> workarounds for specific devices, but those really should be moved to
> their respective SCSI drivers anyway -- after all, manufacturers
> readily slap IDE or SCSI interfaces on the same devices anyway.
> 
> Note that this is specific to ATAPI devices.  ATA hard drives are
> another matter entirely.
> 
> 	-hpa
> 


