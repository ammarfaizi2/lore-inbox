Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUDQI5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 04:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUDQI5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 04:57:13 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:1224 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S263742AbUDQI5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 04:57:11 -0400
Message-ID: <4080F0CA.4030608@superonline.com>
Date: Sat, 17 Apr 2004 11:54:34 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: megaraid2-2.10.3 in 2.4.27-pre (2.4.26+bk)
Content-Type: multipart/mixed;
 boundary="------------040601080207000307010805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040601080207000307010805
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

gcc -D__KERNEL__ -I/home/ozzie/Kernel1/linux-2.4.26/include -Wall 
-Wstrict-protomegaraid2.c:5559: unknown field `vary_io' specified in 
initializer
megaraid2.c:5559: warning: initialization makes pointer from integer 
without a cmake[2]: *** [megaraid2.o] Error 1
make[2]: Leaving directory `/home/ozzie/Kernel1/linux-2.4.26/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
  ake[1]: Leaving directory `/home/ozzie/Kernel1/linux-2.4.26/drivers'
make: *** [_mod_drivers] Error 2


The addition of the vary_io thingy in megaraid2.h is to blame.

Regards;
Özkan Sezer


--------------040601080207000307010805
Content-Type: text/plain;
 name="megaraid2-2.10.3-vary_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="megaraid2-2.10.3-vary_io.patch"

--- ./drivers/scsi/megaraid2.h.ftp-2.10.3
+++ ./drivers/scsi/megaraid2.h
@@ -142,8 +142,7 @@
 	.eh_device_reset_handler =	megaraid_reset,		\
 	.eh_bus_reset_handler =		megaraid_reset,		\
 	.eh_host_reset_handler =	megaraid_reset,		\
-	.highmem_io =			1,			\
+	.highmem_io =			1			\
-	.vary_io =			1			\
 }
 
 

--------------040601080207000307010805--

