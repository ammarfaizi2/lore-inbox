Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264003AbSIQJmu>; Tue, 17 Sep 2002 05:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263989AbSIQJmG>; Tue, 17 Sep 2002 05:42:06 -0400
Received: from [151.17.201.167] ([151.17.201.167]:21008 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S263997AbSIQJko>;
	Tue, 17 Sep 2002 05:40:44 -0400
Message-ID: <3D86F928.B23E34C7@teamfab.it>
Date: Tue, 17 Sep 2002 11:43:04 +0200
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
Organization: TeamSystem Spa
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.22
References: <200209161635.g8GGZaV18210@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
:

I've got this compiler warning :

>> printk.c:263: warning: implicit declaration of function `_vsnprintf'

looking at 2.4.x seem that someone forgot this :

--- linux/include/linux/kernel.h.orig   Sun Mar 25 18:31:03 2001
+++ linux/include/linux/kernel.h        Tue Sep 17 11:26:58 2002
@@ -51,6 +51,7 @@
 extern char *get_options(char *str, int *ints); 
 extern int sprintf(char * buf, const char * fmt, ...);
 extern int vsprintf(char *buf, const char *, va_list);
+extern int _vsnprintf(char *buf, int n, const char *fmt, va_list args);
 
 extern int session_of_pgrp(int pgrp);


ciao,
luca
