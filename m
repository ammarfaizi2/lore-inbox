Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUCHXOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUCHXOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:14:19 -0500
Received: from smtp04.web.de ([217.72.192.208]:34590 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261184AbUCHXOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:14:05 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.4-rc2] bogus semicolon behind if()
Date: Tue, 9 Mar 2004 00:14:01 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403090014.03282.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

recently I found a bogus semicolon an if statement. So I was searching for 
other possible problems with following command:

find linux-2.6.4-rc2 -name "*.c" -exec grep -Hn "\<if[[:space:]]*(\([^()]\|
([^()]*)\)*)[[:space:]]*;" {} \;

That found following possible problems:

linux-2.6.4-rc2/arch/um/kernel/tt/tracer.c:257:		if(WIFEXITED(status)) ;
linux-2.6.4-rc2/arch/i386/kernel/io_apic.c:2200:				if (check_nmi_watchdog() < 
0);
linux-2.6.4-rc2/arch/i386/kernel/io_apic.c:2224:				if (check_nmi_watchdog() < 
0);
linux-2.6.4-rc2/drivers/atm/iphase.c:155:     if (!desc1) ;
linux-2.6.4-rc2/drivers/net/wan/pc300_drv.c:3664:			if (card->chan[i].d.dev);
linux-2.6.4-rc2/drivers/net/tokenring/ibmtr.c:613:	else if 
(ti->shared_ram_paging == 0xf);  /* No paging in adapter */
linux-2.6.4-rc2/drivers/usb/misc/speedtch.c:92:#define DEBUG_ON(x)	do { if 
(x); } while (0)
linux-2.6.4-rc2/drivers/usb/media/w9968cf.c:3374:		if (tuner.tuner != 0);
linux-2.6.4-rc2/drivers/isdn/capi/capiutil.c:438:	else if (c <= 0x0f);
linux-2.6.4-rc2/drivers/isdn/hisax/hfc_sx.c:385:	if (Read_hfc(cs, 
HFCSX_INT_S1));
linux-2.6.4-rc2/drivers/isdn/hisax/hfc_sx.c:415:	if (Read_hfc(cs, 
HFCSX_INT_S2));
linux-2.6.4-rc2/drivers/isdn/hisax/hfc_sx.c:1290:						if (Read_hfc(cs, 
HFCSX_INT_S1));
linux-2.6.4-rc2/drivers/isdn/hisax/hfc_pci.c:131:	if (Read_hfc(cs, 
HFCPCI_INT_S1));
linux-2.6.4-rc2/drivers/isdn/hisax/hfc_pci.c:161:	if (Read_hfc(cs, 
HFCPCI_INT_S1));
linux-2.6.4-rc2/drivers/isdn/hisax/hfc_pci.c:1543:						if (Read_hfc(cs, 
HFCPCI_INT_S1));
linux-2.6.4-rc2/drivers/s390/scsi/zfcp_erp.c:2057:		if (status == 
ZFCP_ERP_SUCCEEDED) ;	/* no further action */
linux-2.6.4-rc2/drivers/scsi/sg.c:356:	if (ppos != &filp->f_pos) ;	/* FIXME: 
Hmm.  Seek to the right place, or fail?  */
linux-2.6.4-rc2/drivers/scsi/sg.c:514:	if (ppos != &filp->f_pos) ;	/* FIXME: 
Hmm.  Seek to the right place, or fail?  */

Best regards
   Thomas Schlichter

P.S.: Wouldn't it be nice if gcc complained about these mistakes?

