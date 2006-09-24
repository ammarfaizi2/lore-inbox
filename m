Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWIXUwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWIXUwR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWIXUwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:52:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45216 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932088AbWIXUwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:52:16 -0400
Subject: Re: [S390] remove old z90crypt driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200609222101.k8ML1w93019317@hera.kernel.org>
References: <200609222101.k8ML1w93019317@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 21:51:55 +0100
Message-Id: <1159131115.24527.956.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 21:01 +0000, Linux Kernel Mailing List wrote:
> [S390] remove old z90crypt driver.
> 
> The z90crypt driver has served its term. It is replaced by the shiny
> new zcrypt device driver.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

You neglected to remove the defunct z90crypt.h from
include/asm-s390/Kbuild, breaking 'make headers_install' on s390.

You also neglected to export the new asm/zcrypt.h too. This should fix
both:

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- a/include/asm-s390/Kbuild
+++ b/include/asm-s390/Kbuild
@@ -6,7 +6,7 @@ header-y += qeth.h
 header-y += tape390.h
 header-y += ucontext.h
 header-y += vtoc.h
-header-y += z90crypt.h
+header-y += zcrypt.h

 unifdef-y += cmb.h
 unifdef-y += debug.h

-- 
dwmw2

