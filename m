Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTDTSaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbTDTS37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:29:59 -0400
Received: from mx0.gmx.net ([213.165.64.100]:43894 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S263669AbTDTS35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:29:57 -0400
Date: Sun, 20 Apr 2003 20:41:52 +0200 (MEST)
From: Matthias Brinkmann <Lead_Crow@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: 2.4.21-pre7: make_install error for ide-Drivers
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0002230372@gmx.net
X-Authenticated-IP: [80.136.180.112]
Message-ID: <19396.1050864112@www53.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I compiled an 2.4.21-pre7 kernel with modularized IDE-Drivers. When I tried
to install
the modules, I got the following error:

Errors from make modules_install:
-------------------
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.21-pre7; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre7/kernel/drivers/ide/ide-probe.o
depmod: 	do_ide_request
depmod: 	ide_add_generic_settings
depmod: 	create_proc_ide_interfaces
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre7/kernel/drivers/ide/ide.o
depmod: 	ide_add_proc_entries
depmod: 	proc_ide_read_capacity
depmod: 	proc_ide_create
depmod: 	ide_remove_proc_entries
depmod: 	destroy_proc_ide_drives
depmod: 	proc_ide_destroy
depmod: 	create_proc_ide_interfaces
------------------


Consequenty an 'modprobe ide-cd' failed with this error:
--------------------
modprobe: Too deep recursion in module dependencies!
modprobe: Circular dependency? ide-iops ide-lib ide ide-cd
Aborted
-----------------------


I want to add that I took the config from an 2.4.18 kernel, where the IDE
drivers
worked with no problem.


Could it be a problem that I cross-compiled the kernel on an Athlon/1200+
machine and
then copied the whole stuff to the target system (Pentiom 133)?

Some Ideas what went wrong? Bug, Feature or only my Dumbness?


Compiler: gcc 3.0.4
System: SuSE Linux 8.0


TIA,
Matthias

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
Bitte lächeln! Fotogalerie online mit GMX ohne eigene Homepage!

