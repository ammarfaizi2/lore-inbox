Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTFVNBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbTFVNBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:01:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8714 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264956AbTFVNBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:01:38 -0400
Date: Sun, 22 Jun 2003 14:15:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Eivind Tagseth <eivindt@multinet.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030622141541.B16537@flint.arm.linux.org.uk>
Mail-Followup-To: Eivind Tagseth <eivindt@multinet.no>,
	linux-kernel@vger.kernel.org
References: <20030620081846.GB2451@tagseth-trd.consultit.no> <20030620211640.B913@flint.arm.linux.org.uk> <20030622114642.GB1785@tagseth-trd.consultit.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030622114642.GB1785@tagseth-trd.consultit.no>; from eivindt@multinet.no on Sun, Jun 22, 2003 at 01:46:42PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 01:46:42PM +0200, Eivind Tagseth wrote:
> > There is this which fixes some people problems, and is already in Linus'
> > recent bk tree.  Does this solve your problem?
> 
> Nope, no change I'm afraid.

There appears to be something of an inconsistency in the naming (again)
for ide-cs.  This should fix it.

--- orig/drivers/ide/legacy/ide-cs.c	Sat Jun 14 22:33:52 2003
+++ linux/drivers/ide/legacy/ide-cs.c	Sun Jun 22 14:14:35 2003
@@ -473,7 +473,7 @@
 static struct pcmcia_driver ide_cs_driver = {
 	.owner		= THIS_MODULE,
 	.drv		= {
-		.name	= "ide_cs",
+		.name	= "ide-cs",
 	},
 	.attach		= ide_attach,
 	.detach		= ide_detach,

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

