Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVEPRkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVEPRkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEPRkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:40:08 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:58817 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261477AbVEPRjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:39:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j6JPjOqnKuIROoSnpfYsLMVDfQn6VU25MAHPbdDhHQb1P7PTeKDOL4ndpvgFbz1heTW7XJLAb3edYGDEMWKV3c7cSYZVcAX+vFvDVCT6TTyt8x9pPO7wbo67ZzKr5ESU1TfGad7nERBkek74Iw+2yw87U2rvPGcmrTOuqOx2OLY=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Danny ter Haar <dth@picard.cistron.nl>
Subject: Re: 2.6.12-rc4-mm2
Date: Mon, 16 May 2005 21:43:07 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050516021302.13bd285a.akpm@osdl.org> <200505161615.50884.adobriyan@gmail.com> <d6ak89$vr8$1@news.cistron.nl>
In-Reply-To: <d6ak89$vr8$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505162143.08155.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 21:11, Danny ter Haar wrote:
> Alexey Dobriyan  <adobriyan@gmail.com> wrote:
> >> Alexey Dobriyan  <adobriyan@gmail.com> wrote:
> >> >Does this help?
> >> Nope, (unfortunatly)
> >Please, try this.
> 
> [Patch #2 applied]
> 
> Still not succesful..
> 
> Error is at
> http://newsgate.newsserver.nl/kernel/2.6.12-rc4-mm2-patch%232-error-out.txt

Urgh... ACPI uses catch-all header file.

If this won't work, I'll get a cross-compiler.

--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/time.c	2005-05-16 21:38:04.000000000 +0400
+++ linux-2.6.12-rc4-mm2-acpi/arch/x86_64/kernel/time.c	2005-05-16 21:38:49.000000000 +0400
@@ -27,7 +27,7 @@
 #include <linux/bcd.h>
 #include <linux/kallsyms.h>
 #include <linux/acpi.h>
-#include <acpi/achware.h>	/* for PM timer frequency */
+#include <acpi/acpi.h>
 #include <asm/8253pit.h>
 #include <asm/pgtable.h>
 #include <asm/vsyscall.h>
