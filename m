Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWJQQRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWJQQRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWJQQRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:17:33 -0400
Received: from xenotime.net ([66.160.160.81]:40337 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751271AbWJQQRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:17:33 -0400
Date: Tue, 17 Oct 2006 09:19:01 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: config SYSCTL_SYSCALL
Message-Id: <20061017091901.7193312a.rdunlap@xenotime.net>
In-Reply-To: <453519EE.76E4.0078.0@novell.com>
References: <453519EE.76E4.0078.0@novell.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 16:59:10 +0100 Jan Beulich wrote:

> What is the purpose of
> 
> config SYSCTL_SYSCALL
> 	bool "Sysctl syscall support" if EMBEDDED
> 	default n
> 
> Allowing only embedded to turn this *on* ? Normally, you want
> embedded to have more freedom in turning stuff off, so this
> looks odd to me (and on one of my older boxes I definitely have
> at least one OS-provided tool that uses this syscall, so I'd like
> to be able to turn it on.

You can't enable it (after enabling EMBEDDED)?

Feel free to send a patch to remove /if EMBEDDED/
and move the Kconfig entry up above all of the EMBEDDED options.

---
~Randy
