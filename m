Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272567AbTHJIcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTHJIcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:32:12 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:5132 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S272567AbTHJIcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:32:11 -0400
Date: Sun, 10 Aug 2003 17:32:15 +0900 (JST)
Message-Id: <20030810.173215.102258218.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, jmorris@intercode.com.au
CC: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: virt_to_offset() (Re: [RFC][PATCH] Make cryptoapi non-optional?)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030810081529.GX31810@waste.org>
References: <20030809194627.GV31810@waste.org>
	<20030809131715.17a5be2e.davem@redhat.com>
	<20030810081529.GX31810@waste.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030810081529.GX31810@waste.org> (at Sun, 10 Aug 2003 03:15:29 -0500), Matt Mackall <mpm@selenic.com> says:

:
> +	sg[0].page = virt_to_page(tmp);
> +	sg[0].offset = ((long) tmp & ~PAGE_MASK);
> +	sg[0].length = sizeof(tmp);

BTW, we spread ((long) ptr & ~PAGE_MASK); it seems ugly.
Why don't we have vert_to_offset(ptr) or something like this?
#define virt_to_offset(ptr) ((unsigned long) (ptr) & ~PAGE_MASK)
Is this bad idea?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
