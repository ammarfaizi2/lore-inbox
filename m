Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRABE2r>; Mon, 1 Jan 2001 23:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130237AbRABE2i>; Mon, 1 Jan 2001 23:28:38 -0500
Received: from c252.h203149202.is.net.tw ([203.149.202.252]:18562 "EHLO
	mail.tahsda.org.tw") by vger.kernel.org with ESMTP
	id <S130113AbRABE2S>; Mon, 1 Jan 2001 23:28:18 -0500
Message-ID: <3A515199.5388E685@teatime.com.tw>
Date: Tue, 02 Jan 2001 11:57:13 +0800
From: Tommy Wu <tommy@teatime.com.tw>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
X-Mailer: Mozilla 4.76 [zh] (Windows NT 5.0; U)
X-Accept-Language: en,zh,zh-TW,zh-CN
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sparc64 compile error for 2.4.0-prerelease
In-Reply-To: <3A513089.9AF6EB6A@teatime.com.tw> <200101020252.SAA01602@pizda.ninka.net>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" ¼g¹D:
> 
> See testing/prerelease-diff
> 

  This patch still has problem for define 'HZ' in 'asm-sparc64/delay.h'.
  It defined in linux/param.h.

--- delay.old   Tue Jan  2 11:53:34 2001
+++ delay.h     Tue Jan  2 11:43:17 2001
@@ -8,6 +8,7 @@
 #define __SPARC64_DELAY_H

 #include <linux/config.h>
+#include <linux/param.h>
 #ifdef CONFIG_SMP
 #include <linux/sched.h>
 #include <asm/smp.h>

  

-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 31515964 24Hrs V.Everything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
