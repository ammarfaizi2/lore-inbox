Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282992AbRK0XkM>; Tue, 27 Nov 2001 18:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282985AbRK0XkE>; Tue, 27 Nov 2001 18:40:04 -0500
Received: from f131.law4.hotmail.com ([216.33.149.131]:5390 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S282989AbRK0Xju>;
	Tue, 27 Nov 2001 18:39:50 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: PATCH fdomain-2.4.16
Date: Tue, 27 Nov 2001 23:39:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1316YzTMnKXkKo7G450000933a@hotmail.com>
X-OriginalArrivalTime: 27 Nov 2001 23:39:44.0873 (UTC) FILETIME=[CB135590:01C1779C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- /tmp/foo/fdomain.c.orig	Sun Sep 30 21:26:07 2001
+++ drivers/scsi/fdomain.c	Tue Nov 27 23:59:59 2001
@@ -729,13 +729,13 @@
       switch (Quantum) {
       case 2:			/* ISA_200S */
       case 3:			/* ISA_250MG */
-	 base = readb(bios_base + 0x1fa2) + (readb(bios_base + 0x1fa3) << 8);
+	 base = isa_readb(bios_base + 0x1fa2) + (isa_readb(bios_base + 0x1fa3) << 
8);
	 break;
       case 4:			/* ISA_200S (another one) */
-	 base = readb(bios_base + 0x1fa3) + (readb(bios_base + 0x1fa4) << 8);
+	 base = isa_readb(bios_base + 0x1fa3) + (isa_readb(bios_base + 0x1fa4) << 
8);
	 break;
       default:
-	 base = readb(bios_base + 0x1fcc) + (readb(bios_base + 0x1fcd) << 8);
+	 base = isa_readb(bios_base + 0x1fcc) + (isa_readb(bios_base + 0x1fcd) << 
8);
	 break;
       }

@@ -1955,7 +1955,7 @@
	 offset = bios_base + 0x1f31 + drive * 25;
	 break;
       }
-      memcpy_fromio( &i, offset, sizeof( struct drive_info ) );
+      isa_memcpy_fromio( &i, offset, sizeof( struct drive_info ) );
       info_array[0] = i.heads;
       info_array[1] = i.sectors;
       info_array[2] = i.cylinders;



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

