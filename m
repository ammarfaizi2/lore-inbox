Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWB0CAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWB0CAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 21:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWB0CAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 21:00:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750826AbWB0CAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 21:00:54 -0500
Date: Sun, 26 Feb 2006 17:59:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm2 configs
Message-Id: <20060226175959.45efd7cc.akpm@osdl.org>
In-Reply-To: <20060226170940.220cc347.rdunlap@xenotime.net>
References: <20060226170940.220cc347.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> 
> a.  why does SONY_ACPI default to m ?  Other similar options are default n.

Because I got heartily sick of losing the setting each time I went back to
a mainline kernel and did `make oldconfig'.

> b.  config LSF
> 	bool "Support for Large Single Files"
> 	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
> 	default n
> 	help
> 	  When CONFIG_LBD is disabled, say Y here if you want to
> 	  handle large file(bigger than 2TB), otherwise say N.
> 	  When CONFIG_LBD is enabled, Y is set automatically.
> 
> This config option appears to be unimplemented and the Help text is
> incorrect:  it is not set to Y automatically when CONFIG_LBD is enabled.
> Where did this come from?

2tb-files-*.patch.

That config option needs to go away, but the developer didn't seem to agree
with or appreciate that at the time.

