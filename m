Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbUCYDzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbUCYDzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:55:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:37300 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263151AbUCYDzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:55:05 -0500
Date: Wed, 24 Mar 2004 19:55:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/22] Add __early_param for all arches
Message-Id: <20040324195502.00a5b148.akpm@osdl.org>
In-Reply-To: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trini@kernel.crashing.org wrote:
>
> Hello.  The following is outcome of talking with David Woodhouse about
> the need in various parts of the kernel to parse the command line very
> early and set some options based on what we read.  The result is
> __early_param("arg", fn) based very heavily on the macro of the same name
> in the arm kernel.  The following is the core of these changes, adding the
> macro, struct and externs to <linux/init.h>, the parser to init/main.c
> and converting console= to this format.  As a follow on to this thread are
> patches against all arches (vs 2.6.5-rc2) to use the global define of
> saved_command_line, add the appropriate bits to
> arch/$(ARCH)/kernel/vmlinux.lds.S and in some cases, convert params
> from the old arch-specific variant to the new __early_param way.

I don't recall seeing this requirement mentioned before, and that's a ton
of patches you have there.

Please tell us a little more about why we need these patches.  (Apart from
what seems to be a moderate amount of code consolidation).

Also, what is different between __setup and __early_setup?  Why is it not
possible to make __setup run sufficiently early for whatever application is
requiring these changes?

Thanks.
