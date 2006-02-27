Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWB0BI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWB0BI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWB0BI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:08:26 -0500
Received: from xenotime.net ([66.160.160.81]:35042 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750709AbWB0BI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:08:26 -0500
Date: Sun, 26 Feb 2006 17:09:40 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: 2.6.16-rc4-mm2 configs
Message-Id: <20060226170940.220cc347.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a.  why does SONY_ACPI default to m ?  Other similar options are default n.

b.  config LSF
	bool "Support for Large Single Files"
	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
	default n
	help
	  When CONFIG_LBD is disabled, say Y here if you want to
	  handle large file(bigger than 2TB), otherwise say N.
	  When CONFIG_LBD is enabled, Y is set automatically.

This config option appears to be unimplemented and the Help text is
incorrect:  it is not set to Y automatically when CONFIG_LBD is enabled.
Where did this come from?

---
~Randy
