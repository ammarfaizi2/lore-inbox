Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUKCFWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUKCFWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 00:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKCFWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 00:22:37 -0500
Received: from cantor.suse.de ([195.135.220.2]:15840 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261436AbUKCFWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 00:22:35 -0500
To: dhowells@redhat.com
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com.suse.lists.linux.kernel>
	<200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Nov 2004 06:14:41 +0100
In-Reply-To: <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com.suse.lists.linux.kernel>
Message-ID: <p733bzr8qf2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhowells@redhat.com writes:

> diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/Makefile linux-2.6.10-rc1-bk10-frv/Makefile
> --- /warthog/kernels/linux-2.6.10-rc1-bk10/Makefile	2004-11-01 11:45:20.000000000 +0000
> +++ linux-2.6.10-rc1-bk10-frv/Makefile	2004-11-01 11:48:36.397037723 +0000
> @@ -497,11 +497,18 @@
>  # Defaults vmlinux but it is usually overriden in the arch makefile
>  all: vmlinux
>  
> +
> +ifdef CONFIG_DEBUG_INFO
> +CFLAGS		+= -g -O1

Please don't do that. At least on i386/x86-64 we want the same
code with debug info as without. Otherwise how would you debug
a problem that only shows up at -O2. 

-Andi

P.S.: And it's quite unfriendly to put subscriber post only
mailing lists into cc of linux kernel threads. Dropped.
