Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTBIQqb>; Sun, 9 Feb 2003 11:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBIQqb>; Sun, 9 Feb 2003 11:46:31 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:4739 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S267291AbTBIQqa>;
	Sun, 9 Feb 2003 11:46:30 -0500
Date: Sun, 9 Feb 2003 19:54:08 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4 more extra semicolons bugs
Message-ID: <20030209165408.GA19368@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030208171838.GA2230@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    It is a boring sunday here today, so I decided to play with gcc -W
    on a 2.4.21-pre4 (from current bitkeeper tree) with all the stuff
    possible compiled in.
    Seems that megaraid and 8253xtty have extra semicolons. Nothing
    too serious, though.

Bye,
    Oleg
===== drivers/net/wan/8253x/8253xtty.c 1.1 vs edited =====
--- 1.1/drivers/net/wan/8253x/8253xtty.c	Thu Apr  4 23:05:10 2002
+++ edited/drivers/net/wan/8253x/8253xtty.c	Sun Feb  9 19:32:58 2003
@@ -2131,7 +2131,7 @@
 	/* Check whether or not the port is open in SYNC mode */
 	if(port->open_type == OPEN_SYNC_NET)
 	{
-		if(port->dev && netif_carrier_ok(port->dev));
+		if(port->dev && netif_carrier_ok(port->dev))
 		{
 			port->tty= NULL;	/* Don't bother with open counting here
 						   but make sure the tty field is NULL*/
===== drivers/scsi/megaraid.c 1.21 vs edited =====
--- 1.21/drivers/scsi/megaraid.c	Fri Dec 13 12:29:59 2002
+++ edited/drivers/scsi/megaraid.c	Sun Feb  9 19:39:12 2003
@@ -4936,7 +4936,7 @@
 		if( ioc.mbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
 			put_user( scsicmd->result, &uioc->pthru.scsistatus );
 			if (copy_to_user( uioc->pthru.reqsensearea, scsicmd->sense_buffer,
-							  MAX_REQ_SENSE_LEN ));
+							  MAX_REQ_SENSE_LEN ))
 				ret= -EFAULT;
 		} else {
 			put_user(1, &uioc->mbox[16]);	/* numstatus */
