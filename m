Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVILDH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVILDH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 23:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVILDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 23:07:27 -0400
Received: from dvhart.com ([64.146.134.43]:17537 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751133AbVILDH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 23:07:27 -0400
Date: Sun, 11 Sep 2005 20:07:25 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.13-mm2
Message-ID: <201750000.1126494444@[10.10.2.4]>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got my damned x440 box back - won't build -mm2 (-mm1 is fine)

arch/i386/kernel/srat.c:141: #error "MAX_NR_ZONES != 3, chunk_to_zone requires review"
make[1]: *** [arch/i386/kernel/srat.o] Error 1
make: *** [arch/i386/kernel] Error 2
09/11/05-00:57:13 Build the kernel. Failed rc = 2
09/11/05-00:57:13 build: kernel build Failed rc = 1
09/11/05-00:57:13 command complete: (2) rc=126

x86_64-dma32.patch:-#define MAX_NR_ZONES                3       /* Sync this wi
h ZONES_SHIFT */
x86_64-dma32.patch:-#define ZONES_SHIFT         2       /* ceil(log2(MAX_NR_ZON
S)) */
x86_64-dma32.patch:+#define MAX_NR_ZONES                4       /* Sync this wi
h ZONES_SHIFT */
x86_64-dma32.patch:+#define ZONES_SHIFT         3       /* ceil(log2(MAX_NR_ZON
S)) */

Andi, does that need changing on ia32 as well as x86_64, or are you
just missing some ifdefs? Looks to me like the rest of the patch is
specific to x86_64.

M.


