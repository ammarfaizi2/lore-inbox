Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267967AbTB1PSd>; Fri, 28 Feb 2003 10:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267974AbTB1PSd>; Fri, 28 Feb 2003 10:18:33 -0500
Received: from mail2.sig.nl ([139.178.250.5]:20229 "HELO mail2.sig.nl")
	by vger.kernel.org with SMTP id <S267967AbTB1PSb>;
	Fri, 28 Feb 2003 10:18:31 -0500
From: "Han Holl" <han.holl@prismant.nl>
To: linux-kernel@vger.kernel.org
Subject: Bug report bounced + bug report
Date: Fri, 28 Feb 2003 16:28:46 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281628.46969.han.holl@prismant.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I tried to report a bug in kernel 2.2.23 to Alan.Cox@linux.org, as instructed
by the 2.2.23 documents, but got a bounce message:                       
                       The Postfix program

<Alan.Cox@linux.org>: Name service error for domain linux.org: Host found but
    no data record of requested type

Here is the bug report:

Subject: Cannot boot Compaq Smart Array 532 with grub on 2.2.23

Hi,

Well, subject says it all really. Here is a (minimal) patch:
 
--- main.c.orig Fri Feb 28 15:56:54 2003
+++ main.c      Fri Feb 28 15:40:37 2003
@@ -495,6 +495,8 @@
        { "sdn",     0x08d0 },
        { "sdo",     0x08e0 },
        { "sdp",     0x08f0 },
+       { "cciss/c0d0p",0x6800 },
+       { "cciss/c0d1p",0x6810 },
        { "rd/c0d0p",0x3000 },
        { "rd/c0d1p",0x3008 },
        { "rd/c0d2p",0x3010 },

Cheers,

Han Holl

