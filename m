Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269303AbUIBXbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269303AbUIBXbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUIBX2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:28:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:13514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269304AbUIBX2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:28:10 -0400
Date: Thu, 2 Sep 2004 16:25:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: bunk@fs.tum.de, ncunningham@linuxmail.org, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
Message-Id: <20040902162545.6b7ae079.akpm@osdl.org>
In-Reply-To: <4137A8E4.9090803@am.sony.com>
References: <20040831221348.GW3466@fs.tum.de>
	<20040831153649.7f8a1197.akpm@osdl.org>
	<20040831225244.GY3466@fs.tum.de>
	<1093993946.8943.33.camel@laptop.cunninghams>
	<20040831163914.4c7c543c.akpm@osdl.org>
	<20040902194600.GE15358@fs.tum.de>
	<4137A8E4.9090803@am.sony.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird <tim.bird@am.sony.com> wrote:
>
> Finally, I think it's bad form to change the meaning of a compiler
> keyword.  It misleading for 'inline' to mean something different
> in the kernel than it does everywhere else.  It means a developer
> can't use standard gcc documentation to understand kernel code, without
> inside knowledge.  This can be painful for casual or new kernel
> developers.

yes, it's horrid.  But until and unless gcc gets fixed, what choice do we
have?  Without this hack, kernel text size increases significantly.

We don't want to have to patch the kernel source in a zillion places for
what is hopefully a temporary problem.  I'd much rather add `--dwim-dammit'
to the gcc command line.

> +#include <linux/compiler.h>	/* for inline weirdness */
>   #include <asm/param.h>

Mozilla white-space-stuffed your patch.  You'll have to use attachments.

