Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTEIQf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTEIQf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:35:28 -0400
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:9389 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S263319AbTEIQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:35:19 -0400
Date: Fri, 9 May 2003 18:47:53 +0200 (CEST)
From: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.21-rc2 : modular ide stil broken 
Message-ID: <Pine.LNX.4.44.0305091847200.3984-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ave 

Modular ide is still broken on 2.4.21--rc2.
make modules_install gives me:

depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc2/kernel/drivers/ide/ide-disk.o
depmod: 	proc_ide_read_geometry
depmod: 	ide_remove_proc_entries
depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc2/kernel/drivers/ide/ide-probe.o
depmod: 	do_ide_request
depmod: 	ide_add_generic_settings
depmod: 	create_proc_ide_interfaces
depmod: *** Unresolved symbols in /lib/modules/2.4.21-rc2/kernel/drivers/ide/ide.o
depmod: 	ide_release_dma
depmod: 	ide_add_proc_entries
depmod: 	cmd640_vlb
depmod: 	ide_probe_for_cmd640x
depmod: 	ide_scan_pcibus
depmod: 	proc_ide_read_capacity
depmod: 	proc_ide_create
depmod: 	ide_remove_proc_entries
depmod: 	destroy_proc_ide_drives
depmod: 	proc_ide_destroy
depmod: 	create_proc_ide_interfaces


Question: Is this gonna be fixed or is this a 2.4.22-pre item?

I know the ide-layer is rewritten and is now much like 2.5.x
In 2.5.x modular ide is also broken and probably priority item no 20000 on 
the list of bugs to fix. And IMHO this is right.  Better first fix real 
bugs in 2.5.x before devoting time to fixing rare cases like this.

In 2.4.x however modular ide worked (at least in 2.4.20) , and I use it to 
make a strip down kernel for  my rescue/nfsroot floppydisk.
As I am no coder, I have no idea how much work or how invasive a patch would be
to get it working again in 2.4.21-rc.  As we are in rc2 stage, I can 
imagine waiting till 2.4.22-pre  is the best option. However could someone in
 the know tell me if it is possible to get it fixed in rc3/final?


Greetz Mu





