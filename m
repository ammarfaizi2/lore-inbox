Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272410AbTHIQRw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272411AbTHIQRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:17:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29360 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272410AbTHIQRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:17:50 -0400
Date: Sat, 09 Aug 2003 12:17:19 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH][TRIVIAL 2.4]  Removal of an unused function in
 arch/i386/kernel/time.c
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F351E8F.8040509@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_KTT+9UjDAjuY/2h5196ycg)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_KTT+9UjDAjuY/2h5196ycg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    the attached patch fixes a compile warning about an unused function, 
if CONFIG_X86_SUMMIT is NOT defined.

    Patch applies to 2.4.22-rc1-ac1.

Stephane Ouellette.


--Boundary_(ID_KTT+9UjDAjuY/2h5196ycg)
Content-type: text/plain; name=time.c-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=time.c-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/arch/i386/kernel/time.c	Fri Aug  8 22:34:38 2003
+++ linux-2.4.22-rc1-ac1-fixed/arch/i386/kernel/time.c	Sat Aug  9 10:39:57 2003
@@ -431,7 +431,6 @@
 
 const int use_cyclone = 0;
 static void mark_timeoffset_cyclone(void) {}
-static unsigned long do_gettimeoffset_cyclone(void) {return 0;}
 static void init_cyclone_clock(void) {}
 void __cyclone_delay(unsigned long loops) {}
 #endif /* CONFIG_X86_SUMMIT */

--Boundary_(ID_KTT+9UjDAjuY/2h5196ycg)--
