Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRKKUb6>; Sun, 11 Nov 2001 15:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280764AbRKKUbt>; Sun, 11 Nov 2001 15:31:49 -0500
Received: from ns2.wticorp.com ([209.185.218.3]:49925 "HELO
	exchange.wticorp.com") by vger.kernel.org with SMTP
	id <S280531AbRKKUbb>; Sun, 11 Nov 2001 15:31:31 -0500
Message-ID: <3BEEE054.B645C700@wticorp.com>
Date: Sun, 11 Nov 2001 12:32:20 -0800
From: Dennis Vadura <dvadura@wticorp.com>
Organization: Web Tools International
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Kernel 2.4.14 - drivers/block/loop.c fails to link
In-Reply-To: <3BEEDE50.9E91BD99@wticorp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deleted reference to deactivate_page. Tested patch by mounting 
and reading RH 7.2 ISO images and all seemed fine.

--- linux-2.4.14/drivers/block/loop.c   Thu Oct 25 13:58:34 2001
+++ linux/drivers/block/loop.c  Sun Nov 11 12:01:29 2001
@@ -207,7 +207,6 @@
                index++;
                pos += size;
                UnlockPage(page);
-               deactivate_page(page);
                page_cache_release(page);
        }
        return 0;
@@ -218,7 +217,6 @@
        kunmap(page);
 unlock:
        UnlockPage(page);
-       deactivate_page(page);
        page_cache_release(page);
 fail:
        return -1;
