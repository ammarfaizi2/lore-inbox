Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbSI3E1E>; Mon, 30 Sep 2002 00:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261918AbSI3E1D>; Mon, 30 Sep 2002 00:27:03 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:2825 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261916AbSI3E1D>; Mon, 30 Sep 2002 00:27:03 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8E0@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: kai-germaschewski@uiowa.edu, davej@codemonkey.org.uk
cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Date: Sun, 29 Sep 2002 23:32:22 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11890C5D1784934-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	drivers/{s390,macintosh,acorn}/
> makes it (IMO) cleaner to share drivers between 
> e.g. s390 and  s390x, or possibly i386/x86_64 in the future.

The i386 EDD "driver" could probably be shared with x86-64, I hadn't thought
about it before.  Likewise the IA64 efivars driver *may* eventually be
shared with x86 or others if Intel's plans come to fruition.  So I'd vote
for something in drivers/ rather than arch/ for such shareable modules.  I'm
open to moving each of these if told where the "right" place should be.
Neither are char or block drivers, so those don't make sense - purely
driverfs/proc interfaces.  Nor are they "bus" drivers ala ide or scsi.
drivers/misc is empty and I think people want to keep it that way...

Some ideas for these:
drivers/i386
drivers/efi

Thoughts?

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

