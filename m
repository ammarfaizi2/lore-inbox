Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHFRBa>; Tue, 6 Aug 2002 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSHFRBa>; Tue, 6 Aug 2002 13:01:30 -0400
Received: from mail05.svc.cra.dublin.eircom.net ([159.134.118.21]:51025 "HELO
	mail05.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id <S313558AbSHFRB3> convert rfc822-to-8bit; Tue, 6 Aug 2002 13:01:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: John Kinsella <rfjak@gofree.indigo.ie>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 compile warning for AMD Athlon config
Date: Tue, 6 Aug 2002 18:09:35 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020806170129Z313558-685+24825@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 21:56, you wrote:
> amd_adv_spec_cache_feature() tries to use have_cpuid_p(), which does not
> exist in 2.4.x tree.
>

Doh,
	it does of course exist, but it might benefit from a forward declaration to
suppress compiler warning.

--- 2.4.19/arch/i386/kernel/setup.c     Sun Aug  4 14:17:35 2002
+++ 2.4.19/arch/i386/kernel/setup.c.tmp Tue Aug  6 14:39:58 2002
@@ -171,6 +171,8 @@
 extern int root_mountflags;
 extern char _text, _etext, _edata, _end;

+static int have_cpuid_p(void);
+
 static int disable_x86_serial_nr __initdata = 1;
 static int disable_x86_fxsr __initdata = 0;
 static int disable_x86_ht __initdata = 0;
