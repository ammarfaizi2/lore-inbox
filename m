Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTJMQRc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTJMQRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:17:31 -0400
Received: from imladris.surriel.com ([66.92.77.98]:20160 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261893AbTJMQRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:17:22 -0400
Date: Mon, 13 Oct 2003 12:17:06 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Thomas Horsten <thomas@horsten.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] question marks again
In-Reply-To: <Pine.LNX.4.40.0310131708290.25290-100000@jehova.dsm.dk>
Message-ID: <Pine.LNX.4.55L.0310131216310.27244@imladris.surriel.com>
References: <Pine.LNX.4.40.0310131708290.25290-100000@jehova.dsm.dk>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Thomas Horsten wrote:

> > +     * 0x08     (?)  !S_BSY
>
> At least keep it lined up..

Oops.  Too many patches at once.  Fixed now.


diff -urNp linux-5110/drivers/scsi/imm.c linux-10010/drivers/scsi/imm.c
--- linux-5110/drivers/scsi/imm.c
+++ linux-10010/drivers/scsi/imm.c
@@ -322,10 +322,10 @@ static unsigned char imm_wait(int host_n
      * STR      imm     imm
      * ===================================
      * 0x80     S_REQ   S_REQ
-     * 0x40     !S_BSY  (????)
+     * 0x40     !S_BSY  (?)
      * 0x20     !S_CD   !S_CD
      * 0x10     !S_IO   !S_IO
-     * 0x08     (????)  !S_BSY
+     * 0x08     (?)     !S_BSY
      *
      * imm      imm     meaning
      * ==================================
@@ -927,7 +927,7 @@ static void imm_interrupt(void *data)
 	printk("imm: told to abort\n");
 	break;
     case DID_PARITY:
-	printk("imm: parity error (???)\n");
+	printk("imm: parity error (?)\n");
 	break;
     case DID_ERROR:
 	printk("imm: internal driver error\n");
@@ -936,7 +936,7 @@ static void imm_interrupt(void *data)
 	printk("imm: told to reset device\n");
 	break;
     case DID_BAD_INTR:
-	printk("imm: bad interrupt (???)\n");
+	printk("imm: bad interrupt (?)\n");
 	break;
     default:
 	printk("imm: bad return code (%02x)\n", (cmd->result >> 16) & 0xff);
