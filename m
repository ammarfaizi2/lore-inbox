Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUJSWat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUJSWat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUJSWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:25:29 -0400
Received: from alpha.lic1.vsi.ru ([80.82.34.34]:65218 "EHLO alpha.lic1.vsi.ru")
	by vger.kernel.org with ESMTP id S269896AbUJSWX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:23:59 -0400
Message-ID: <417593F1.3090300@lic1.vsi.ru>
Date: Wed, 20 Oct 2004 02:23:45 +0400
From: "Igor A. Valcov" <viaprog@lic1.vsi.ru>
Reply-To: viaprog@lic1.vsi.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Semen <semen@basdesign.ru>
Subject: net-tools-1.60 build failed on 2.6.9
Content-Type: multipart/mixed;
 boundary="------------000709060405070208030304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000709060405070208030304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Without this patch (apply to /usr/include/netinet/if_fddi.h) build 
net-tools-1.60 failed

gcc -D_GNU_SOURCE -O3 -march=pentium4 -mcpu=pentium4 -mmmx -msse -msse2 
-mfpmath=sse  -I. -idirafter ./include/ -Ilib 
-I/var/tmp/portage/net-tools-1.60-r9/work/net-tools-1.60 -idirafter 
/var/tmp/portage/net-tools-1.60-r9/work/net-tools-1.60/include    -c -o 
fddi.o fddi.c
In file included from /usr/include/netinet/if_fddi.h:26,
                  from fddi.c:30:
/usr/include/linux/if_fddi.h:110: error: field `gen' has incomplete type

-- 
Igor A. Valcov

--------------000709060405070208030304
Content-Type: text/plain;
 name="if_fddi.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="if_fddi.h.diff"

--- if_fddi.h.bak	2004-10-20 02:15:18.127214584 +0400
+++ if_fddi.h	2004-10-20 02:15:32.225071384 +0400
@@ -23,6 +23,7 @@
 #include <sys/types.h>
 #include <asm/types.h>
 
+#include <linux/netdevice.h>
 #include <linux/if_fddi.h>
 
 #ifdef __USE_BSD

--------------000709060405070208030304--
