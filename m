Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268290AbTBYVnh>; Tue, 25 Feb 2003 16:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268298AbTBYVnh>; Tue, 25 Feb 2003 16:43:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:14515 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268290AbTBYVne>;
	Tue, 25 Feb 2003 16:43:34 -0500
Date: Tue, 25 Feb 2003 13:50:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, alistair@devzero.co.uk, cloos@jhcloos.com,
       elenstev@mesatop.com, jordan.breeding@attbi.com, maneesh@in.ibm.com,
       scole@lanl.gov, solarce@fallingsnow.net
Subject: Re: Patch: 2.5.62 devfs shrink
Message-Id: <20030225135032.7c9663da.akpm@digeo.com>
In-Reply-To: <200302251023.CAA01067@adam.yggdrasil.com>
References: <200302251023.CAA01067@adam.yggdrasil.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 21:53:40.0508 (UTC) FILETIME=[5B928DC0:01C2DD18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> wrote:
>
> 	Here is an update to my patch to shrink devfs for linux-2.5.62.

Adam, could you please provide a description of the incompatibilities between
this implementation and the present one?  For both kernel and userspace.

And would you also please provide a list of operations which people need to
perform to migrate existing setups to the new code.

And should I drop the below patch?

diff -puN init/do_mounts.c~devfs-fix init/do_mounts.c
--- 25/init/do_mounts.c~devfs-fix	2003-01-16 19:39:56.000000000 -0800
+++ 25-akpm/init/do_mounts.c	2003-01-16 19:39:56.000000000 -0800
@@ -853,11 +853,6 @@ void prepare_namespace(void)
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

