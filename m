Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSIIBMq>; Sun, 8 Sep 2002 21:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSIIBMq>; Sun, 8 Sep 2002 21:12:46 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:24840 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S315458AbSIIBMp>; Sun, 8 Sep 2002 21:12:45 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CC75@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org, greg@kroah.com
cc: phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Date: Sun, 8 Sep 2002 20:17:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1165292E1697910-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So in this example, we are exporting a number of boot devices as the
> > bios told us, so apply the rule stated above, and determine 
> > if it should go into /proc or not[1].
> 
> This is interesting, and I look forward to delving into the 
> code. ACPI is  doing something very similar. One thing I
> would like to do is create a 'platform' or 'firmware'
> top-level directory in driverfs in which all the 
> various firmware drivers can display the data they ascertain from the 
> firmware. Stay tuned..

Likewise, on IA-64, /proc/efi/ has EFI stuff (really only vars/ right now,
direct access to NVRAM variables), which coincidentally, I wrote, which
would benefit from a top-level 'platform' or 'firmware' directory and
migration to driverfs.  Code is in arch/ia64/kernel/efivars.c.  Once I nail
down the EDD code, moving efivars.c to driverfs shouldn't be hard.

> Two examples are attached:

Thanks, that helps a lot.  I need to still find how to walk the list of
existing devices and gather info, for purposes of making symlinks, but I see
the existing devices that do that to use as examples.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)


