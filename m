Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422826AbWA1FMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWA1FMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 00:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWA1FMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 00:12:17 -0500
Received: from mail.majordomo.ru ([81.177.16.8]:61445 "EHLO mail.majordomo.ru")
	by vger.kernel.org with ESMTP id S1422826AbWA1FMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 00:12:16 -0500
Message-ID: <43DB2550.4070800@nndl.org>
Date: Sat, 28 Jan 2006 11:03:28 +0300
From: "Nikolay N. Ivanov" <nn@nndl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: PROBLEM: kernel bug at net/core/net-sysfs.c:434 - kernel 2.6.16rc1
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

---
CC      net/core/net-sysfs.o
net/core/net-sysfs.c: In function `netdev_register_sysfs':
net/core/net-sysfs.c:434: error: `i' undeclared (first use in this function)
net/core/net-sysfs.c:434: error: (Each undeclared identifier is reported 
only once
net/core/net-sysfs.c:434: error: for each function it appears in.)
net/core/net-sysfs.c:434: error: `attr' undeclared (first use in this 
function)
make[2]: *** [net/core/net-sysfs.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2
[nn@ linux-2.6.16-rc1]$ gcc --version
gcc (GCC) 3.3.4
---

After adding:

int i;

new errors appeared:

---
CC      net/core/net-sysfs.o
net/core/net-sysfs.c: In function `netdev_register_sysfs':
net/core/net-sysfs.c:434: error: `attr' undeclared (first use in this 
function)
net/core/net-sysfs.c:434: error: (Each undeclared identifier is reported 
only once
net/core/net-sysfs.c:434: error: for each function it appears in.)
make[2]: *** [net/core/net-sysfs.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2
---

-- 
Nikolay N. Ivanov
mailto: nn@nndl.org

