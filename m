Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266919AbUHMS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUHMS7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHMS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:59:10 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:39133 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266878AbUHMS6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:58:34 -0400
Message-ID: <411D0F25.3070205@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:57:41 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] nwflash.c -EFAULT retcode
Content-Type: multipart/mixed;
	boundary="------------020103060908060200010606"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103060908060200010606
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

missing -EFAULT retcode in nwflash.c, from 2.6

=D6zkan Sezer


--------------020103060908060200010606
Content-Type: text/plain;
	name="nwflash-2.6-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="nwflash-2.6-fixes.diff"

--- 27rc5~/drivers/char/nwflash.c	2004-08-07 14:02:42.000000000 +0300
+++ 27rc5/drivers/char/nwflash.c	2004-08-07 14:18:04.000000000 +0300
@@ -159,7 +159,8 @@
 		if (ret == 0) {
 			ret = count;
 			*ppos = p + count;
-		}
+		} else
+			ret = -EFAULT;
 		up(&nwflash_sem);
 	}
 	return ret;


--------------020103060908060200010606--
