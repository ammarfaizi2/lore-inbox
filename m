Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274337AbUKBHDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274337AbUKBHDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S767098AbUKBHDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:03:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54675 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S286760AbUKBHDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:03:05 -0500
Date: Tue, 2 Nov 2004 08:03:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [oops] lib/vsprintf.c
In-Reply-To: <200411020719.55570.pluto@pld-linux.org>
Message-ID: <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr>
References: <200411020719.55570.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,


>static int km_init_module(void)
>{
>    printk(KERN_DEBUG "%s init\n", 1.4);
>    return 0;
>}

You do know that %s does not mix with 1.4?


>vsprintf.c-      case 's':
>vsprintf.c-                    s = va_arg(args, char *);
>vsprintf.c-                    if ((unsigned long)s < PAGE_SIZE)
>vsprintf.c-                           s = "<NULL>";
>vsprintf.c-
>vsprintf.c:      OOPS!  =>     len = strnlen(s, precision);




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
