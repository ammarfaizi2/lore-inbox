Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293441AbSCARYL>; Fri, 1 Mar 2002 12:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCARYB>; Fri, 1 Mar 2002 12:24:01 -0500
Received: from AMontpellier-201-1-1-61.abo.wanadoo.fr ([193.252.31.61]:47620
	"EHLO awak") by vger.kernel.org with ESMTP id <S293423AbSCARXv>;
	Fri, 1 Mar 2002 12:23:51 -0500
Subject: [2.4.19-pre1-ac1] usbnet frames mangled
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 01 Mar 2002 18:23:48 +0100
Message-Id: <1015003428.2274.5.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

using an ipaq running 2.4.17-rmk5-hh5 as "usb client" (usbnet
connection), I got lots frames mangled (about 95%). For example, a
typical ping request:

0000  48 3f 05 1f 43 9a c6 33  f5 8f d9 b3 08 00 45 00   H?..C..3 ......E.
0010  00 54 00 00 40 00 40 01  36 a5 01 01 01 01 01 01   .T..@.@. 6.......
0020  01 02 08 00 86 99 df 00  05 00 b5 bd 7f 3c 65 68   ........ .....<eh
0030  08 00 08 09 0a 0b 0c 0d  0e 0f 10 11 12 13 14 15   ........ ........
0040  16 17 18 19 1a 1b 1c 1d  1e 1f 20 21 22 23 24 25   ........ .. !"#$%
0050  26 27 28 29 2a 2b 2c 2d  2e 2f 30 31 32 33 34 35   &'()*+,- ./012345
0060  36 37                                              67               

is often received as:

0000  16 17 18 19 1a 1b 1c 1d  1e 1f 20 21 22 23 24 25   ........ .. !"#$%
0010  26 27 28 29 2a 2b 2c 2d  2e 2f 30 31 32 33 34 35   &'()*+,- ./012345
0020  36 37                                              67               

which of course doesn't mean anything. I saw this behavior since I
upgraded my desktop from 2.4.18-ac2 to 2.4.19-pre1-ac1

