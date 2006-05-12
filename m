Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWELNE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWELNE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWELNE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:04:26 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:220 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751269AbWELNEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:04:25 -0400
Date: Fri, 12 May 2006 15:04:17 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Trent Piepho <xyzzy@speakeasy.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <20060512130417.GA6182@linuxtv.org>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.229.31
Subject: Re: Linux v2.6.17-rc4
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 11, 2006, Linus Torvalds wrote:
> 
> Ok, I've let the release time between -rc's slide a bit too much again, 
> but -rc4 is out there, and this is the time to hunker down for 2.6.17.
> 
> If you know of any regressions, please holler now, so that we don't miss 
> them. 

Not a recent regression, but symbol_put_addr() will solidly
deadlock. A patch has been posted twice, but got no
response. I would like to see symbol_put_addr() fixed
in 2.6.17.

I attach a previous mail where I explain why we would
like to use this for DVB stuff. You can also find
the original postings here:
http://lkml.org/lkml/2006/4/28/226
http://lkml.org/lkml/2006/5/4/194

symbol_put_addr() currently has no users, that's
why the brokenness went unnoticed for so long.


Johannes

--qDbXVdCdHGoSgWSk
Content-Type: message/rfc822
Content-Disposition: inline

Received: from www.linuxtv.org ([212.227.166.180])
	by allen.werkleitz.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.61)
	(envelope-from <linux-kernel-owner+js=40linuxtv.org-S1751408AbWEDVaf@vger.kernel.org>)
	id 1FblPb-0000qF-6q
	for js@sig21.net; Thu, 04 May 2006 23:31:12 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by www.linuxtv.org with esmtp (Exim 4.50)
	id 1FblPa-0003H8-8H
	for js@linuxtv.org; Thu, 04 May 2006 23:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWEDVaf (ORCPT <rfc822;js@linuxtv.org>);
	Thu, 4 May 2006 17:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEDVaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:30:35 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:49300 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751408AbWEDVa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:30:29 -0400
Received: from p54bdfbe9.dip.t-dialin.net ([84.189.251.233] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.61)
	(envelope-from <js@linuxtv.org>)
	id 1FblOn-0000pp-S9; Thu, 04 May 2006 23:30:20 +0200
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1FblPT-00028U-00; Thu, 04 May 2006 23:30:55 +0200
Date: Thu, 4 May 2006 23:30:55 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Trent Piepho <xyzzy@speakeasy.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Andrew de Quincey <adq_dvb@lidskialf.net>
Message-ID: <20060504213055.GB8113@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-SA-Exim-Connect-IP: 212.227.166.180
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on allen.werkleitz.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=4.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO autolearn=unavailable version=3.1.0
Subject: [xyzzy@speakeasy.org: [PATCH] symbol_put_addr() locks kernel]
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)

Hi,

could you please have a look at the original message
and the attached patch?

Background:

Many people complain that one driver for a DVB PCI or
USB card depends on many frontend (== tuner + demodulator)
modules. Although one card usually has only one frontend,
we have these many dependencies because of the many existing
card variants.

As a way out, we try to replace a static dependency
in the frontend probe function with a combination of
symbol_request() and symbol_put_addr(). symbol_request()
would only be called for the frontends known to exists
for a given PCI or USB device id.

Thanks,
Johannes

----- Forwarded message from Trent Piepho <xyzzy@speakeasy.org> -----

Subject: [PATCH] symbol_put_addr() locks kernel
Date:	Fri, 28 Apr 2006 15:23:55 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
To: linux-kernel@vger.kernel.org
cc: xyzzy@speakeasy.org
X-Mailing-List:	linux-kernel@vger.kernel.org

Please CC me on any replies, I'm not subscribed.

Even since a previous patch:

Fix race between CONFIG_DEBUG_SLABALLOC and modules
Sun, 27 Jun 2004 17:55:19 +0000 (17:55 +0000)
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commit;h=92b3db26d31cf21b70e3c1eadc56c179506d8fbe

The function symbol_put_addr() will deadlock the kernel.
symbol_put_addr() acquires the modlist_lock spinlock, then calls
kernel_text_address() and module_text_address() while it still holds
the lock.  That patch changed those two functions so they also try to
acquire the spinlock, which of course locks the kernel.

If you look at the original thread:  http://lkml.org/lkml/2004/6/23/20
The first patch corrected symbol_put_addr() to use the new
"double-underscore" functions that don't try to acquire the lock, but
the final patch missed symbol_put_addr().

Here is a patch which fixes this.  The locking inside
symbol_put_addr() is removed.  I changed symbol_put_addr() to call
core_kernel_text() instead of kernel_text_address(), the latter
includes an additional check if the addr is inside a module.  Since we
will call module_text_address() to get the module, this extra check
isn't needed.
# HG changeset patch
# User Trent Piepho <xyzzy@speakeasy.org>
# Node ID b66f3aa4bfe88f9ea2edb9c87419413ecc6caa8c
# Parent  4c3f241d7bc53fc25ddab54140f96cacd71ae1e1
From: Trent Piepho <xyzzy@speakeasy.org>

symbol_put_addr() would acquire modlist_lock, then while holding the lock call
two functions kernel_text_address() and module_text_address() which also try
to acquire the same lock.  This deadlocks the kernel of course.

This patch changes symbol_put_addr() to not acquire the modlist_lock, it
doesn't need it since it never looks at the module list directly.  Also, it
now uses core_kernel_text() instead of kernel_text_address().  The latter
has an additional check for addr inside a module, but we don't need to do that
since we call module_text_address() (the same function kernel_text_address
uses) ourselves.


Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>

 
 include/linux/kernel.h |    1 +
 kernel/extable.c       |    2 +-
 kernel/module.c        |   14 +++++++-------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff -r 4c3f241d7bc5 -r b66f3aa4bfe8 include/linux/kernel.h
--- a/include/linux/kernel.h	Fri Apr 28 23:00:35 2006 +0700
+++ b/include/linux/kernel.h	Fri Apr 28 14:49:34 2006 -0700
@@ -124,6 +124,7 @@ extern char *get_options(const char *str
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(char *ptr, char **retptr);
 
+extern int core_kernel_text(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
diff -r 4c3f241d7bc5 -r b66f3aa4bfe8 kernel/extable.c
--- a/kernel/extable.c	Fri Apr 28 23:00:35 2006 +0700
+++ b/kernel/extable.c	Fri Apr 28 14:49:34 2006 -0700
@@ -40,7 +40,7 @@ const struct exception_table_entry *sear
 	return e;
 }
 
-static int core_kernel_text(unsigned long addr)
+int core_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext &&
 	    addr <= (unsigned long)_etext)
diff -r 4c3f241d7bc5 -r b66f3aa4bfe8 kernel/module.c
--- a/kernel/module.c	Fri Apr 28 23:00:35 2006 +0700
+++ b/kernel/module.c	Fri Apr 28 14:49:34 2006 -0700
@@ -705,14 +705,14 @@ EXPORT_SYMBOL(__symbol_put);
 
 void symbol_put_addr(void *addr)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	if (!kernel_text_address((unsigned long)addr))
+	struct module *modaddr;
+
+	if (core_kernel_text((unsigned long)addr))
+		return;
+
+	if (!(modaddr = module_text_address((unsigned long)addr)))
 		BUG();
-
-	module_put(module_text_address((unsigned long)addr));
-	spin_unlock_irqrestore(&modlist_lock, flags);
+	module_put(modaddr);
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 


----- End forwarded message -----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--qDbXVdCdHGoSgWSk--
