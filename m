Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264710AbRF3EUM>; Sat, 30 Jun 2001 00:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264718AbRF3EUD>; Sat, 30 Jun 2001 00:20:03 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:36364 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264710AbRF3ETt>;
	Sat, 30 Jun 2001 00:19:49 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Byeong-ryeol Kim <jinbo21@hananet.net>
cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: compile error about do_softirq in 2.4.5-ac21 
In-Reply-To: Your message of "Sat, 30 Jun 2001 10:07:20 +0900."
             <Pine.LNX.4.33.0106301005060.23402-100000@progress.plw.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jun 2001 14:19:38 +1000
Message-ID: <31885.993874778@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001 10:07:20 +0900 (KST), 
Byeong-ryeol Kim <jinbo21@hananet.net> wrote:
>>>background.c:57: `do_softirq_Rf0a529b7' undeclared (first use in \
>>>                this function)

Missing include in fs/jffs2/background.c.  spin_unlock_bh() needs the
definition of do_softirq().  Against 2.4.5-ac21, will fit -ac22 as well.

Index: 5.52/fs/jffs2/background.c
--- 5.52/fs/jffs2/background.c Sun, 22 Apr 2001 07:25:55 +1000 kaos (linux-2.4/Z/d/7_background 1.1 644)
+++ 5.52(w)/fs/jffs2/background.c Sat, 30 Jun 2001 14:13:12 +1000 kaos (linux-2.4/Z/d/7_background 1.1 644)
@@ -43,6 +43,7 @@
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
+#include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include "nodelist.h"
 
 

