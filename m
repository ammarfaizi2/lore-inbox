Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSHAXZQ>; Thu, 1 Aug 2002 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSHAXZQ>; Thu, 1 Aug 2002 19:25:16 -0400
Received: from u212-239-148-114.freedom.planetinternet.be ([212.239.148.114]:22790
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S317314AbSHAXZP>; Thu, 1 Aug 2002 19:25:15 -0400
Message-Id: <200208012327.g71NRWZp013762@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.30 unresolved symbol: elv_queue_empty
Date: Fri, 02 Aug 2002 01:27:32 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The subject says nearly all: with 2.5.30, I get the following:

depmod: *** Unresolved symbols in /lib/modules/2.5.30/kernel/drivers/block/floppy.o
depmod:         elv_queue_empty
depmod: *** Unresolved symbols in /lib/modules/2.5.30/kernel/drivers/ide/atapi.o
depmod:         elv_queue_empty
depmod: *** Unresolved symbols in /lib/modules/2.5.30/kernel/drivers/ide/ide-mod.o
depmod:         elv_queue_empty

Oh, while I'm at it: ever since the IDE cleanup started, loading one
or more of the IDE/CD related modules for a second time after they 
have been unloaded once already results in a pretty bad oops (total
lockup). Took me quite a while to narrow this down. 2.5.29 still has 
this problem. I was going to submit the oops for 2.5.30 if applicable, 
but first gotta get that symbol resolved...

This is on a measly SMP P5 with limited memory which is all-SCSI 
except for the CD drive. Hence the modules.

Regards,

  MCE
-- 
========================================================================
M. Eyckmans (MCE)          Code of the Geeks v3.1       mce-at-pi-dot-be
GCS d+ s+:- a36 C+++$ UHLUASO+++$ P+ L+++ E--- W++ N+++ !o K w--- !O M--
 V-- PS+ PE+ Y+ PGP- t--- !5 !X R- tv- b+ DI++ D-- G++ e+++ h+(*) !r y?
========================================================================

