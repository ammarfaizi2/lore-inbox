Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbTFQRIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbTFQRIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:08:34 -0400
Received: from srv1.rt.mipt.ru ([194.85.82.97]:2678 "EHLO srv1.rt.mipt.ru")
	by vger.kernel.org with ESMTP id S264849AbTFQRId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:08:33 -0400
Date: Tue, 17 Jun 2003 21:22:15 +0400
From: Andrey Ulanov <drey@rt.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21] problems with __u64 and ansi mode
Message-ID: <20030617172215.GA3732@vocord.disorder.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try:

bash-2.05b$ cat t.c
#include <linux/cdrom.h>
bash-2.05b$ gcc -c t.c
bash-2.05b$ gcc -c -ansi t.c
In file included from /usr/include/linux/cdrom.h:14,
                 from t.c:1:
/usr/include/asm/byteorder.h:38: error: parse error before "__u64"
/usr/include/asm/byteorder.h:38: error: parse error before "val"
/usr/include/asm/byteorder.h: In function `___arch__swab64':
/usr/include/asm/byteorder.h:42: error: parse error before "__u64"
/usr/include/asm/byteorder.h: At top level:
/usr/include/asm/byteorder.h:44: error: parse error before '.' token
/usr/include/asm/byteorder.h:52: error: parse error before string constant
In file included from /usr/include/linux/byteorder/little_endian.h:11,
                 from /usr/include/asm/byteorder.h:65,
                 from /usr/include/linux/cdrom.h:14,
                 from t.c:1:
/usr/include/linux/byteorder/swab.h:199: error: parse error before "__fswab64"
/usr/include/linux/byteorder/swab.h:199: error: parse error before "x"
/usr/include/linux/byteorder/swab.h: In function `__fswab64':
/usr/include/linux/byteorder/swab.h:206: error: `x' undeclared (first use in this function)
/usr/include/linux/byteorder/swab.h:206: error: (Each undeclared identifier is reported only once
/usr/include/linux/byteorder/swab.h:206: error: for each function it appears in.)
/usr/include/linux/byteorder/swab.h: At top level:
/usr/include/linux/byteorder/swab.h:209: error: parse error before "__swab64p"
/usr/include/linux/byteorder/swab.h:209: error: parse error before '*' token
/usr/include/linux/byteorder/swab.h: In function `__swab64p':
/usr/include/linux/byteorder/swab.h:211: error: `x' undeclared (first use in this function)
/usr/include/linux/byteorder/swab.h: At top level:
/usr/include/linux/byteorder/swab.h:213: error: parse error before '*' token
/usr/include/linux/byteorder/swab.h: In function `__swab64s':
/usr/include/linux/byteorder/swab.h:215: error: `addr' undeclared (first use in this function)
bash-2.05b$ 

ps. please, cc to me
-- 
with best regards, Andrey Ulanov.
