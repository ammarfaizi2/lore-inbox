Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSCFEFD>; Tue, 5 Mar 2002 23:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293193AbSCFEEx>; Tue, 5 Mar 2002 23:04:53 -0500
Received: from rj.sgi.com ([204.94.215.100]:40622 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293175AbSCFEEs>;
	Tue, 5 Mar 2002 23:04:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jim Cromie <jcromie@divsol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie PATCH: add MODULE_AUTHORS_VERSION macro 
In-Reply-To: Your message of "Tue, 05 Mar 2002 17:17:49 PDT."
             <3C85602D.2090809@divsol.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 15:04:38 +1100
Message-ID: <13833.1015387478@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Mar 2002 17:17:49 -0700, 
Jim Cromie <jcromie@divsol.com> wrote:
>[jimc@groucho linux]$ diff -u module.h module.h.new
>--- module.h    Wed Feb 27 04:22:33 2002
>+++ module.h.new    Tue Mar  5 15:39:39 2002
>@@ -206,6 +206,10 @@
> const char __module_author[] __attribute__((section(".modinfo"))) =     
>   \
> "author=" name
> 
>+#define MODULE_AUTHORS_VERSION(name)                       \
>+const char __module_authors_version[] 
>__attribute__((section(".modinfo"))) = \
>+"authors_version=" name
>+
> #define MODULE_DESCRIPTION(desc)                       \
> const char __module_description[] __attribute__((section(".modinfo"))) 
>=   \
> "description=" desc
>
>1. grep sources and patch modules which have a VERSION of some sort, like
>
>arch/i386/kernel/mtrr.c:#define MTRR_VERSION            "1.40 (20010327)"

mtrr cannot be a module, bool CONFIG_MTRR.

>arch/i386/kernel/microcode.c:#define MICROCODE_VERSION     "1.09"

MODULE_DESCRIPTION("Intel CPU (IA-32) microcode update driver" MICROCODE_VERSION);

No need for another module_* macro.

