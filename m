Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUL0FwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUL0FwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 00:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUL0FwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 00:52:24 -0500
Received: from [202.125.86.130] ([202.125.86.130]:11443 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261750AbUL0FwT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 00:52:19 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: request for member magic in something not a structure or union
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Mon, 27 Dec 2004 11:26:14 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348112B85F6@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: request for member magic in something not a structure or union
Thread-Index: AcTr1amM1PeavxxIQR237V3ouqmR2wAAAtLQ
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
 
I am new to the Fedora Linux. I worked on SuSE and Red Hat Linux. Now I am using Fedora Core 3 with 2.6.9-1.667 kernel version.
 
I got a problem while compiling a module, but the same module is 
working under SuSE 9.1 with 2.6.5, 2.6.6, 2.6.8 and 2.6.9 kernel versions.
 
I understood that the error messages are related to spin_lock_irqsave and 
spin_lock_init only. If I comment those two lines the compilation is OK.

The error messages are ---

 /home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c: In function `do_tifm_transfer':
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `magic' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `lock' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `babble' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `babble' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `module' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `owner' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `oline' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `lock' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `owner' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:933: error: request for member `oline' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:938: error: request for member `magic' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:938: error: request for member `lock' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:938: error: request for member `babble' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:938: error: request for member `babble' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:938: error: request for member `module' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:938: error: request for member `lock' in something not a structure or union
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c: In function `gendisk_init':
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:1090: error: invalid type argument of `->'
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:1090: error: invalid type argument of `->'
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:1090: error: invalid type argument of `->'
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:1090: error: invalid type argument of `->'
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:1090: error: invalid type argument of `->'
/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.c:1090: error: invalid type argument of `->'
make[2]: *** [/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source/tidrv.o] Error 1
make[1]: *** [_module_/home/ti/tifm-2.6.9-1.667-kernel/tifm-1.3-2.6.x-source] Error 2
make: *** [default] Error 2
 
Please any help greatly appreciated. 
Thanks in advance.
 
Regards,
Srinivas G
