Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVJNRWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVJNRWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVJNRWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:22:25 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:3406 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbVJNRWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:22:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=M3Nlrq8jB4JgKvt/08sFZluGWtfWhiWSFrfC3Ji6BKvYwMp4k6yfFpYOGorwpy4MOl5XfoJB/xVcE2QzchfJXdatzd1A9iuOEHwg/JthqkgBJWaz0aZU8eOzk1d+YY8mWeYUUedWFaFuQBzAt6HDPH0GjSDut2B3c7Pedd1PXHc=
Subject: Re: 2.6.14-rc4-rt4
From: Badari Pulavarty <pbadari@gmail.com>
To: John Rigg <lk@sound-man.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1EQSJt-0001Fp-4j@localhost.localdomain>
References: <E1EQSJt-0001Fp-4j@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-7lkhQtqQkARjb2G9hiL3"
Date: Fri, 14 Oct 2005 10:21:47 -0700
Message-Id: <1129310507.6266.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7lkhQtqQkARjb2G9hiL3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-10-14 at 17:22 +0100, John Rigg wrote:
> The header on my last post seems to have been mangled so here it
> is again...
> 
> Ingo, I just tried the patch you posted in reply to Badari Pulavarty's
> boot crash message. I get an error when trying to patch 2.6.14-rc4-rt4:
> 
> patching file arch/x86_64/kernel/vsyscall.c
> patch: **** malformed patch at line 11: notrace
> 

Try this..

I am able to apply cleanly. I am trying to see if it fixes my problem
or not.

Thanks,
Badari



--=-7lkhQtqQkARjb2G9hiL3
Content-Disposition: attachment; filename=notrace.patch
Content-Type: text/x-patch; name=notrace.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14-rc4.org/arch/x86_64/kernel/vsyscall.c	2005-10-07 10:27:33.000000000 -0700
+++ linux-2.6.14-rc4/arch/x86_64/kernel/vsyscall.c	2005-10-14 05:11:02.000000000 -0700
@@ -34,7 +34,7 @@
 #include <asm/errno.h>
 #include <asm/io.h>
 
-#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr))) notrace
 #define force_inline __attribute__((always_inline)) inline
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;

--=-7lkhQtqQkARjb2G9hiL3--

