Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUJRJWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUJRJWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUJRJWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:22:23 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:41668 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S265051AbUJRJWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:22:22 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: prasanna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, ak@muc.de, suparna@in.ibm.com
Subject: Re: [1/2] PATCH Kernel watchpoint interface-2.6.9-rc4-mm1 
In-reply-to: Your message of "Mon, 18 Oct 2004 14:15:25 +0530."
             <20041018084525.GA27936@in.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Oct 2004 19:22:08 +1000
Message-ID: <5418.1098091328@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 14:15:25 +0530, 
Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
>This patch provides global debug register settings.
>Used by kernel watchpoint interface patch.

>+config DEBUGREG
>+	bool "Global Debug Registers"
>+	depends on DEBUG_KERNEL
>+	help
>+	  Global debug register settings will be honoured if this is turned on.
>+	  If in doubt, say "N".
>+

I like most of the patch, but Kconfig is wrong.  This option should not
be exposed to end users, instead CONFIG_DEBUGREG should be selected by
the debug code that calls debugreg.  IOW, kgdb, kdb or kwatch select
debugreg, not the other way around.

