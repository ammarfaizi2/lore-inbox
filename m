Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTDRQF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTDRQFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:05:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56335 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263129AbTDRQD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:03:56 -0400
Date: Fri, 18 Apr 2003 18:17:32 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm4 devfs don't compile
Message-ID: <20030418161732.GA14198@hh.idb.hist.no>
References: <20030418014536.79d16076.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418014536.79d16076.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to try mm4 and see how AS runs on scsi, but
I got a compile error in devfs:

  gcc -Wp,-MD,fs/devfs/.base.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=pentium2 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=base 
-DKBUILD_MODNAME=devfs -c -o fs/devfs/base.o fs/devfs/base.c
fs/devfs/base.c: In function `devfsd_notify':
fs/devfs/base.c:1426: too many arguments to function `devfsd_notify_de'
fs/devfs/base.c: In function `devfs_register':
fs/devfs/base.c:1460: warning: too few arguments for format
fs/devfs/base.c:1460: warning: too few arguments for format
make[2]: *** [fs/devfs/base.o] Error 1
make[1]: *** [fs/devfs] Error 2
make: *** [fs] Error 2

Helge Hafting
