Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274838AbTHPQkB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274884AbTHPQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:40:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:49063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274838AbTHPQj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:39:56 -0400
Date: Sat, 16 Aug 2003 09:40:19 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, axel@pearbough.net
Subject: Re: [Bug 1116] New: build error in drivers/scsi/ide-scsi.c
Message-ID: <20030816164019.GD9735@kroah.com>
References: <32230000.1061041877@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32230000.1061041877@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin, when is the email-to-bugzilla interface going to be up and
working?

On Sat, Aug 16, 2003 at 06:51:17AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=1116
> 
>            Summary: build error in drivers/scsi/ide-scsi.c
>     Kernel Version: 2.6.0-test3-bk
>             Status: NEW
>           Severity: high
>              Owner: andmike@us.ibm.com
>          Submitter: axel@pearbough.net
> 
> 
> Distribution:Slackware-9.0
> Hardware Environment:
> Software Environment:
> Problem Description:build fails at drivers/scsi/ide-scsi.c:951
> drivers/scsi/ide-scsi.c:951: error: unknown field `name' specified in initializer
> Steps to reproduce:drivers/scsi/ide-scsi.c:951: warning: missing braces around initializer
> drivers/scsi/ide-scsi.c:951: warning: (near initialization for `idescsi_primary.node')
> drivers/scsi/ide-scsi.c:951: warning: initialization from incompatible pointer type

Here's a fix for that, sorry...


diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	Sat Aug 16 09:39:27 2003
+++ b/drivers/scsi/ide-scsi.c	Sat Aug 16 09:39:27 2003
@@ -948,7 +948,6 @@
 };
 
 static struct device     idescsi_primary = {
-	.name		= "Ide-scsi Parent",
 	.bus_id		= "ide-scsi",
 };
 static struct bus_type   idescsi_emu_bus = {
