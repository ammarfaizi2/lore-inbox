Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWAOXFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWAOXFO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWAOXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:05:14 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:16845 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1750970AbWAOXFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:05:13 -0500
Message-ID: <43CAD58B.10804@f2s.com>
Date: Sun, 15 Jan 2006 23:06:51 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm26: add L1_CACHE_SHIFT
References: <20060114223448.GA8002@mipter.zuzino.mipt.ru>
In-Reply-To: <20060114223448.GA8002@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> Fix reiserfs compilation as a side effect =)

Obviosuly correct...

Signed-off-by: Ian Molton <spyro@f2s.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

  include/asm-arm26/cache.h |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/asm-arm26/cache.h
+++ b/include/asm-arm26/cache.h
@@ -4,7 +4,8 @@
  #ifndef __ASMARM_CACHE_H
  #define __ASMARM_CACHE_H

-#define        L1_CACHE_BYTES  32
+#define        L1_CACHE_SHIFT  5
+#define        L1_CACHE_BYTES  (1 << L1_CACHE_SHIFT)
  #define        L1_CACHE_ALIGN(x) 
(((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
  #define        SMP_CACHE_BYTES L1_CACHE_BYTES




