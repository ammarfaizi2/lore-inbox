Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318842AbSHTOGU>; Tue, 20 Aug 2002 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318862AbSHTOGU>; Tue, 20 Aug 2002 10:06:20 -0400
Received: from mail44-s.fg.online.no ([148.122.161.44]:14318 "EHLO
	mail44.fg.online.no") by vger.kernel.org with ESMTP
	id <S318842AbSHTOGT>; Tue, 20 Aug 2002 10:06:19 -0400
From: "jools" <j1@gramstad.org>
To: <linux-kernel@vger.kernel.org>
Subject: hpt374 / BUG();
Date: Tue, 20 Aug 2002 16:10:34 +0200
Message-ID: <IOELJIHGBNLBJNBMHABBIEPOCCAA.j1@gramstad.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm using a RocketRAID 404 (hpt374) and a Asus A7v266.
When trying to boot from a 'htp374-enabled' kernel like 2.4.19-ac4 or
2.4.20-pre2-ac4, i keep getting kernel panic at hpt366.c:1393.
Does anyone know why this happens, or what I might do to correct this
problem? I have tried every patch I can find for the 2.4 kernel.

hpt366.c line 1392:

if (hpt_minimum_revision(dev,8))
        BUG();
else if (hpt_minimum_revision(dev,5))
        dev->driver_data = (void *) fifty_base_hpt372;
else if (hpt_minimum_revision(dev,4))
        dev->driver_data = (void *) fifty_base_hpt370a;
else
        dev->driver_data = (void *) fifty_base_hpt370a;
printk("HPT37X: using 50MHz internal PLL\n");
goto init_hpt37X_done;


Jools
j1@gramstad.org

