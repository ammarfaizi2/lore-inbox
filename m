Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269622AbUHZUnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269622AbUHZUnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbUHZUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:42:29 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:44283 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S267770AbUHZUjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:39:53 -0400
Message-ID: <412E4A4F.2040706@ttnet.net.tr>
Date: Thu, 26 Aug 2004 23:38:39 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: bunk@fs.tum.de
CC: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [2.4 patch][5/6] asm-i386/smpboot.h: fix gcc 3.4 compilation
Content-Type: multipart/mixed;
	boundary="------------080205080801020300040703"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080205080801020300040703
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Didn't look at the code much but how about removing the
label as the -ac tree does?


--------------080205080801020300040703
Content-Type: text/plain;
	name="smpboot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="smpboot.patch"

diff -urN 28pre2/include/asm-i386/smpboot.h 28pre2_acx/include/asm-i386/smpboot.h
--- 28pre2/include/asm-i386/smpboot.h	2004-08-08 02:26:06.000000000 +0300
+++ 28pre2_acx/include/asm-i386/smpboot.h	2004-08-26 12:09:44.000000000 +0300
@@ -129,7 +129,6 @@
 			/*round robin the interrupts*/
 			cpu = (cpu+1)%smp_num_cpus;
 			return cpu_to_physical_apicid(cpu);
-		default:
 	}
 	return cpu_online_map;
 }

--------------080205080801020300040703--
