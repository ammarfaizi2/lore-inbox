Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTEADKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 23:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTEADKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 23:10:37 -0400
Received: from lakemtao06.cox.net ([68.1.17.115]:46553 "EHLO
	lakemtao06.cox.net") by vger.kernel.org with ESMTP id S262297AbTEADKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 23:10:35 -0400
Subject: Re: 2.5.68-mm3
From: steven roemen <sdroemen1@cox.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030429235959.3064d579.akpm@digeo.com>
References: <20030429235959.3064d579.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051759115.1001.1.camel@lws04.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Apr 2003 22:18:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i think this has been reported for linus's tree, but i noticed it with
-mm3

Steve

make -f scripts/Makefile.build obj=drivers/ieee1394
  gcc -Wp,-MD,drivers/ieee1394/.nodemgr.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=nodemgr
-DKBUILD_MODNAME=ieee1394 -c -o drivers/ieee1394/.tmp_nodemgr.o
drivers/ieee1394/nodemgr.c
drivers/ieee1394/nodemgr.c: In function `nodemgr_bus_match':
drivers/ieee1394/nodemgr.c:367: structure has no member named
`class_num'
drivers/ieee1394/nodemgr.c: At top level:
drivers/ieee1394/nodemgr.c:497: unknown field `class_num' specified in
initializer
drivers/ieee1394/nodemgr.c:497: warning: excess elements in struct
initializer
drivers/ieee1394/nodemgr.c:497: warning: (near initialization for
`nodemgr_dev_template_ud')
drivers/ieee1394/nodemgr.c:503: unknown field `class_num' specified in
initializer
drivers/ieee1394/nodemgr.c:503: warning: excess elements in struct
initializer
drivers/ieee1394/nodemgr.c:503: warning: (near initialization for
`nodemgr_dev_template_ne')
drivers/ieee1394/nodemgr.c:508: unknown field `class_num' specified in
initializer
drivers/ieee1394/nodemgr.c:508: warning: initialization makes pointer
from integer without a cast
drivers/ieee1394/nodemgr.c: In function `nodemgr_guid_search_cb':
drivers/ieee1394/nodemgr.c:730: structure has no member named
`class_num'
drivers/ieee1394/nodemgr.c: In function `nodemgr_nodeid_search_cb':
drivers/ieee1394/nodemgr.c:767: structure has no member named
`class_num'
drivers/ieee1394/nodemgr.c: In function `nodemgr_driver_search_cb':
drivers/ieee1394/nodemgr.c:1261: structure has no member named
`class_num'
drivers/ieee1394/nodemgr.c: In function `nodemgr_remove_node':
drivers/ieee1394/nodemgr.c:1449: structure has no member named
`class_num'
make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2


