Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269891AbRHTNSN>; Mon, 20 Aug 2001 09:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270593AbRHTNSD>; Mon, 20 Aug 2001 09:18:03 -0400
Received: from elma.elma.fi ([192.89.233.77]:25044 "EHLO elma.elma.fi")
	by vger.kernel.org with ESMTP id <S269891AbRHTNRr>;
	Mon, 20 Aug 2001 09:17:47 -0400
Date: Mon, 20 Aug 2001 16:18:00 +0300 (EETDST)
From: Heikki Pernu <hpernu@Elma.Net>
To: linux-ntfs@tiger.informatik.hu-berlin.de, linux-kernel@vger.kernel.org
cc: heikki.pernu@Elma.FI
Subject: Linux NTFS driver won't compile on 2.4.9
Message-ID: <Pine.A32.3.96.1010820161035.408866B-100000@tokka.elma.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	On official 2.4.9 kernel the included NTFS driver doesn't compile.
	The problem was that unistr.c was using min macro without
	it being defined. 

	The quick fix is to include linux/kernel.h which
	defines this macro.

	Please, apply this to stock kernel ASAP! 
	The official kernel is now broken.

	Here is the patch:
Index: linux/fs/ntfs/unistr.c
===================================================================
RCS file: /usr/local/CVSroot/linux-2.4/fs/ntfs/unistr.c,v
retrieving revision 2.4
diff -c -r2.4 unistr.c
*** linux/fs/ntfs/unistr.c	2001/08/19 17:08:19	2.4
--- linux/fs/ntfs/unistr.c	2001/08/20 13:02:46
***************
*** 23,28 ****
--- 23,29 ----
  
  #include <linux/string.h>
  #include <asm/byteorder.h>
+ #include <linux/kernel.h>
  
  #include "unistr.h"
  #include "macros.h"



