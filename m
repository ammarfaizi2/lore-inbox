Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752474AbWCGCDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbWCGCDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbWCGCDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:03:18 -0500
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:64767 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1752474AbWCGCDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:03:17 -0500
Date: Tue, 07 Mar 2006 11:03:14 +0900 (JST)
Message-Id: <20060307.110314.00927749.nemoto@toshiba-tops.co.jp>
To: akpm@osdl.org
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit unaligned access on 32bit kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060306170552.0aab29c5.akpm@osdl.org>
References: <20050830104056.GA4710@linux-mips.org>
	<20060306.203218.69025300.nemoto@toshiba-tops.co.jp>
	<20060306170552.0aab29c5.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 6 Mar 2006 17:05:52 -0800, Andrew Morton <akpm@osdl.org> said:
>> Use __u64 instead of __typeof__(*(ptr)) for temporary variable to
>> get rid of errors on gcc 4.x.

akpm> I worry about what impact that change might have on code
akpm> generation.  Hopefully none, if gcc is good enough.

akpm> But I cannot think of a better fix.

As I tested on MIPS gcc 3.x, the impact is not none, but not so huge.
And it becomes much smaller with gcc 4.x.

---
Atsushi Nemoto
