Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbTLTQUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 11:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTLTQUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 11:20:55 -0500
Received: from ns.avalon.ru ([195.209.229.227]:25800 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id S264903AbTLTQUy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 11:20:54 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Subject: 2.4 kernel build system, redhat 8.0/9 tricks and modules building...
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Sat, 20 Dec 2003 19:23:31 +0300
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3840E0@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4 kernel build system, redhat 8.0/9 tricks and modules building...
Thread-Index: AcPHFZvI2L7wlh/LSOWbN1eu9MTBqA==
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to figure out how to build any arbitrary module for redhat 8.0/9 kernels...

As I see, they ship with include/linux/modules populated with *.ver files that rely on some macros defined in /boot/kernel.h and include/linux/rhconfig.h through include/linux/modversions.h that included in every module at compile time.

Configuration headers include/linux/autoconf.h and include/linux/version.h source include/linux/rhconfig.h as well, so far all seems good with the tricks that speed up building, but we haven't got any dependen”y files to build modules with the make SUBDIRS=/path/to/module/dir modules command. (Am I right?)

But if someone tries to build dependencies with the make dep, he lost hacked modversions.h that includes rhconfg.h (make {old,c,menu}config command will reset autoconf.h to defaults as well).
Is there any way to compile any module without full cycle rebuilding from make mrproper to make modules?

Thanks in adnvance,
Dimitry.
