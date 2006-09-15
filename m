Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWIOPgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWIOPgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWIOPgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:36:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:1064 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932083AbWIOPgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:36:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=YMHGmj/EWm+6VIuA5BQ0zaJa5uE+Ho+hDRrQeb900LSykZiZ3BGkhNQnpZ92xmfbvnNejgv1CJVUvPZH9aMhRf8bkHRh17t6/4uJWrbCAF8LYRLFmbTCyaoPQDr68lvK8i2GItl4avFRTkv8QeCqD7ByS/MHTI635OYA9Pz4sC0=
Date: Fri, 15 Sep 2006 17:35:46 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: cachefiles on latest -mm fails to build on powerpc
Message-ID: <20060915173546.GE2876@slug>
References: <20060915123132.GA4817@cathedrallabs.org> <20060915155023.GC2876@slug> <20060915151724.GA8098@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915151724.GA8098@cathedrallabs.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:17:24PM -0300, Aristeu Sergio Rozanski Filho wrote:
> > Does the following patch help?
> nope, it doesn't solve the problem :(
> I'll rebuild everything just to make sure isn't anything build related
Err, my bad, is this one any better?

Regards,
Frederik

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 39d3bfc..d6cc301 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -92,6 +92,8 @@ EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 
+EXPORT_SYMBOL(copy_page);
+
 #ifndef  __powerpc64__
 EXPORT_SYMBOL(__ide_mm_insl);
 EXPORT_SYMBOL(__ide_mm_outsw);
