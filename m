Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSFCXqR>; Mon, 3 Jun 2002 19:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSFCXqQ>; Mon, 3 Jun 2002 19:46:16 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:22711 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S315862AbSFCXqP>; Mon, 3 Jun 2002 19:46:15 -0400
Message-Id: <5.1.0.14.2.20020603162827.0831ad78@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Jun 2002 16:46:07 -0700
To: torvalds@transmeta.com
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: [PATCH] 2.5.20 Fix non-modular Bluetooth compilation
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This trivial patch fixes linker error when Bluetooth support is compiled in.

Please apply.
Max

--- linux-2.5/net/bluetooth/af_bluetooth.c.old  Mon Jun  3 16:40:22 2002
+++ linux-2.5/net/bluetooth/af_bluetooth.c      Mon Jun  3 16:40:46 2002
@@ -317,7 +317,7 @@
         PF_BLUETOOTH, bluez_sock_create
  };

-static int __init bluez_init(void)
+int __init bluez_init(void)
  {
         BT_INFO("BlueZ Core ver %s Copyright (C) 2000,2001 Qualcomm Inc",
                  VERSION);


