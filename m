Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFCVEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFCVEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 17:04:06 -0400
Received: from [12.46.110.22] ([12.46.110.22]:23192 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261919AbTFCVEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 17:04:05 -0400
Subject: Make Xconfig compile error on 2.4.21-RC7
From: "B. Joshua Rosen" <bjrosen@polybus.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Polybus Systems Corp
Message-Id: <1054675142.2409.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jun 2003 17:19:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a GCC incompatiblity in the tkparse.c file included in
2.4.21rc7. The system that I did the make on is running Redhat 7.3 with
GCC version 2.96. Here is the error message

/home/tmp/linux-2.4.20> make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/home/tmp/linux-2.4.20/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o
tkparse.c
cc1: Internal error: Illegal instruction.
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[1]: *** [tkparse.o] Error 1
make[1]: Leaving directory `/home/tmp/linux-2.4.20/scripts'
make: *** [xconfig] Error 2


-- 
B. Joshua Rosen <bjrosen@polybus.com>
Polybus Systems Corp
