Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWDKRuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDKRuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWDKRuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:50:46 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:8790 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750840AbWDKRuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:50:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qMXxaNm9ujnlK5FeobBhX4e1qpggx3a4zPMXRVPcis/ux4lZkc4o16BtUlvcb5ReKvCI8lPxeXvFgk9xw6cfqYv0DEltcUU3t0S62KVvZzDg5lv7EsT2np4Y6xPuf/HwRKmYf5ANK0KwxiY2FMi06HKnt1pNirKLf7adq2me+h8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] voyager: no need to define BITS_PER_BYTE when it's already in types.h
Date: Tue, 11 Apr 2006 19:51:25 +0200
User-Agent: KMail/1.9.1
Cc: James.Bottomley@hansenpartnership.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111951.25430.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BITS_PER_BYTE is defined in linux/types.h which is already included by 
arch/i386/mach-voyager/voyager_cat.c , so there's no need to define it 
again.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/mach-voyager/voyager_cat.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.17-rc1-git4-orig/arch/i386/mach-voyager/voyager_cat.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc1-git4/arch/i386/mach-voyager/voyager_cat.c	2006-04-11 19:47:02.000000000 +0200
@@ -114,7 +114,6 @@ static struct resource qic_res = {
  * It writes num_bits of the data buffer in msg starting at start_bit.
  * Note: This function assumes that any unused bit in the data stream
  * is set to zero so that the ors will work correctly */
-#define BITS_PER_BYTE 8
 static void
 cat_pack(__u8 *msg, const __u16 start_bit, __u8 *data, const __u16 num_bits)
 {


