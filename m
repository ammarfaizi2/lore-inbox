Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSGLPHs>; Fri, 12 Jul 2002 11:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSGLPHr>; Fri, 12 Jul 2002 11:07:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6663 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316579AbSGLPHq> convert rfc822-to-8bit;
	Fri, 12 Jul 2002 11:07:46 -0400
Message-ID: <3D2EF169.4070904@evision-ventures.com>
Date: Fri, 12 Jul 2002 17:10:33 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <agl7ov$p91$1@cesium.transmeta.com> <3D2EEF88.2070609@cox.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Kevin P. Fleming napisa³:
> I have had plans for a while to add Media Status Notification to the 
> ide-floppy driver, so it can do more intelligent media change 
> management. To do so requires ATA (NOT ATAPI) commands to be issued to 
> the drive(s). How would this work if ide-scsi is being used to talk to 
> the drives? Would ide-scsi have to be taught about removable media and 
> Media Status Notification?

You would have to hook it up to the following:

/*
  *	SCSI command transformation layer
  */
#define IDESCSI_TRANSFORM		0	/* Enable/Disable transformation */
#define IDESCSI_SG_TRANSFORM		1	/* /dev/sg transformation */

