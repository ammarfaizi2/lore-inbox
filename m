Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbTCGCGb>; Thu, 6 Mar 2003 21:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbTCGCGb>; Thu, 6 Mar 2003 21:06:31 -0500
Received: from CPE-203-45-136-67.qld.bigpond.net.au ([203.45.136.67]:50958
	"EHLO nb1.nb.netbox.net.au") by vger.kernel.org with ESMTP
	id <S261480AbTCGCG1>; Thu, 6 Mar 2003 21:06:27 -0500
Date: Fri, 7 Mar 2003 12:16:56 +1000
From: Menno Smits <menno@netbox.biz>
To: linux-kernel@vger.kernel.org
Subject: Strange power off issues (2.4.20)
Message-Id: <20030307121656.3f1e60db.menno@netbox.biz>
Organization: NetBox
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SERVER01/Oxcoda/AU(Release 5.0.11  |July 24, 2002) at
 07/03/2003 12:16:56 PM,
	Serialize by Router on SERVER01/Oxcoda/AU(Release 5.0.11  |July 24, 2002) at
 07/03/2003 12:16:57 PM,
	Serialize complete at 07/03/2003 12:16:57 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing some strange power off problems with 2.4.20.

When APM or ACPI is enabled and the shutdown/halt/poweroff command is
issued the system will shutdown, power off and then power straight
back on again. The power LED turns off and hard disk begins spinning
down and then power comes straight back on a split second later. 

This problem doesn't occur on the same hardware with 2.2.19 or with
Windows 98 (ie. the system shuts down and stays off). The system in
question has a MSI-6368v5 motherboard (VIA chipset).  Wake-on-LAN,
wake-on-serial etc etc are all turned off in the BIOS.  APM and ACPI
are enabled in the BIOS however.

During my testing I've tried various combinations of APM kernel
options including "Enable PM at boot time" and "Use real mode APM BIOS
call to power off", with no change in behaviour. 

I've seen exactly the same behaviour with an Intel chipset MSI
motherboard. Turning off the "Use real mode APM BIOS call to power
off" kernel option seemed to fix it for that system. Unfortunately I
no longer have access to it to test things further.

Any advice on what might be going on would be greatly appreciated.
Extensive googling and experimentation has got me nowhere so far.

-- 
Menno Smits 
