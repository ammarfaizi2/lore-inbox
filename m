Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUGCQ7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUGCQ7f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGCQ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 12:59:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:25774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265152AbUGCQ7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 12:59:34 -0400
Date: Sat, 3 Jul 2004 09:53:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: MTRR __initdata confusion.
Message-Id: <20040703095304.5aa685c4.rddunlap@osdl.org>
In-Reply-To: <20040703164143.GV7101@redhat.com>
References: <20040703164143.GV7101@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004 17:41:43 +0100 Dave Jones wrote:

| smp_changes_mask is used by generic_set_all() which isn't __init
| 
| Signed-off-by: Dave Jones <davej@redhat.com>
| 
| 		Dave
| 		
| --- FC2/arch/i386/kernel/cpu/mtrr/generic.c~	2004-07-03 17:40:00.408094696 +0100
| +++ FC2/arch/i386/kernel/cpu/mtrr/generic.c	2004-07-03 17:40:05.666295328 +0100
| @@ -18,7 +18,7 @@
|  	mtrr_type def_type;
|  };
|  
| -static unsigned long smp_changes_mask __initdata = 0;
| +static unsigned long smp_changes_mask = 0;
|  struct mtrr_state mtrr_state = {};

"= 0" can be dropped, as in the patch that I posted abour 2 weeks back:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108727726300903&w=2

--
~Randy
