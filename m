Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSLXPIH>; Tue, 24 Dec 2002 10:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSLXPIH>; Tue, 24 Dec 2002 10:08:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:52882 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264010AbSLXPIG>;
	Tue, 24 Dec 2002 10:08:06 -0500
Message-ID: <3E087A37.DDF392D0@digeo.com>
Date: Tue, 24 Dec 2002 07:16:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kronos@kronoz.cjb.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] Cannot open root device
References: <20021224131957.GA549@dreamland.darkstar.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Dec 2002 15:16:11.0826 (UTC) FILETIME=[64A03920:01C2AB5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kronos wrote:
> 
> I have some problems booting kernel 2.5.53, it seems to be unable to
> find my root fs:
> 
> VFS: Cannot open root device "305" or 03:05
> 

Does this fix t?


--- 25/init/do_mounts.c~devfs-fix	Tue Dec 24 07:15:16 2002
+++ 25-akpm/init/do_mounts.c	Tue Dec 24 07:15:21 2002
@@ -848,11 +848,6 @@ void prepare_namespace(void)
 {
 	int is_floppy;
 
-#ifdef CONFIG_DEVFS_FS
-	sys_mount("devfs", "/dev", "devfs", 0, NULL);
-	do_devfs = 1;
-#endif
-
 	md_run_setup();
 
 	if (saved_root_name[0]) {

_
