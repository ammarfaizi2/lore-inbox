Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTFOFyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 01:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTFOFyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 01:54:32 -0400
Received: from rth.ninka.net ([216.101.162.244]:28544 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261887AbTFOFyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 01:54:32 -0400
Subject: Re: [PATCH] fix weird kmalloc bug
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@digeo.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
In-Reply-To: <16107.55733.155825.17744@cargo.ozlabs.ibm.com>
References: <16107.55733.155825.17744@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055657277.6481.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 23:07:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-14 at 19:28, Paul Mackerras wrote:
> This patch fixes it by including asm/page.h and asm/cache.h in
> linux/slab.h.  The list in kmalloc_sizes.h depends on L1_CACHE_BYTES
> as well as PAGE_SIZE, which is why I added asm/cache.h.

Please use linux/cache.h, we should provide some kind of
"#error don't directly include asm/blah.h" protection into
various headers such as asm/cache.h, asm/delay.h, etc.

-- 
David S. Miller <davem@redhat.com>
