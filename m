Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSLKW51>; Wed, 11 Dec 2002 17:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbSLKW50>; Wed, 11 Dec 2002 17:57:26 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:53207 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S266318AbSLKW5Y>;
	Wed, 11 Dec 2002 17:57:24 -0500
Subject: IDE PCMCIA badness
From: Stian Jordet <liste@jordet.nu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1039647958.651.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 00:05:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, is this normal? I know unmount of ide-pcmcia devices don't work. The
device works perfect, but I get this message upon boot:

hde: PCMCIA/SD ADAPTER, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 19
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 62720 sectors (32 MB) w/1KiB Cache, CHS=490/4/32
 hde: hde1
 hde: hde1
Badness in kobject_register at lib/kobject.c:113
Call Trace: [<c01e9b05>]  [<c017368c>]  [<c01737e9>]  [<c022f6de>] 
[<c022f624>]  [<c022f62c>]  [<c025eea8>]  [<c02642be>]  [<c026077d>] 
[<c025a9c6>]  [<c025f2fe>]  [<c025fd67>]  [<c0267b62>]  [<c011f51b>] 
[<c026806a>]  [<c02a04d3>]  [<c0298300>]  [<c02984bb>]  [<c0298a32>] 
[<c0299125>]  [<c029a257>]  [<c029a361>]  [<c0115cb5>]  [<c02a0f69>] 
[<c0298f43>]  [<c0298d39>]  [<c02984bb>]  [<c029a322>]  [<c02a0f69>] 
[<c02a04d3>]  [<c0298300>]  [<c02984bb>]  [<c0298a32>]  [<c0299125>] 
[<c029a257>]  [<c029a361>]  [<c0115cb5>]  [<c02a0f69>]  [<c0298f43>] 
[<c0298d39>]  [<c02984bb>]  [<c029a322>]  [<c0298a32>]  [<c0298f1b>] 
[<c0298f43>]  [<c029a4a2>]  [<c01846f7>]  [<c014495b>]  [<c01846f7>] 
[<c018a7b2>]  [<c018475d>]  [<c0184d9d>]  [<c017bbff>]  [<c0268290>] 
[<c029d829>]  [<c010ab21>]  [<c010ab4f>]  [<c029e9ce>]  [<c0267a57>] 
[<c0268214>]  [<c029f797>]  [<c029f7d9>]  [<c02a01cd>]  [<c03043a8>] 
[<c012fdae>]  [<c012fe39>]  [<c0138320>]  [<c0138388>]  [<c0138681>] 
[<c0115782>]  [<c0130363>]  [<c01300db>]  [<c0133d25>]  [<c013709d>] 
[<c01370fd>]  [<c013f972>]  [<c013a10a>]  [<c0139fa5>]  [<c0139fc0>] 
[<c013a377>]  [<c0154069>]  [<c0108b83>] 
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1


Btw, why does it write _three_ times hde: hde1? It does this with 2.4 as
well.

Best regards,
Stian Jordet

