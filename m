Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268366AbTBNMZB>; Fri, 14 Feb 2003 07:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268372AbTBNMZB>; Fri, 14 Feb 2003 07:25:01 -0500
Received: from [81.80.245.157] ([81.80.245.157]:7136 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S268366AbTBNMZA>; Fri, 14 Feb 2003 07:25:00 -0500
Date: Fri, 14 Feb 2003 13:34:34 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile failure in include/asm-i386/mach-default/mach_apic.h
Message-ID: <20030214123433.GD15048@cedar.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Jan Dittmer <j.dittmer@portrix.net>, mingo@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3E4CC6A3.9020102@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4CC6A3.9020102@portrix.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 11:36:19AM +0100, Jan Dittmer wrote:

> I need to include asm/apic.h and asm/mpspec.h in 
> include/asm-i386/mach-default/mach_apic.h to compile current 2.5.60 bk tree.
> .config attached. Didn't find it on lkml.
> Uniprocessor w/ local apic enabled, but happens also with local apic 
> disabled.
> Is this the correct fix?

I think the patch below is better...

Stelian.

===== arch/i386/kernel/acpi/boot.c 1.21 vs edited =====
--- 1.21/arch/i386/kernel/acpi/boot.c	Thu Feb 13 18:51:14 2003
+++ edited/arch/i386/kernel/acpi/boot.c	Fri Feb 14 10:18:03 2003
@@ -24,8 +24,11 @@
  */
 
 #include <linux/init.h>
+#include <linux/config.h>
 #include <linux/acpi.h>
 #include <asm/pgalloc.h>
+#include <asm/mpspec.h>
+#include <asm/apic.h>
 
 #include <mach_apic.h>
 #include <mach_mpparse.h>

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
