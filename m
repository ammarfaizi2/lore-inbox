Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVJZHWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVJZHWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVJZHWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:22:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932562AbVJZHWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:22:37 -0400
Date: Wed, 26 Oct 2005 00:22:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/6] Uml - reuse i386 cpu-specific tuning
Message-Id: <20051026002200.1ebb06f2.akpm@osdl.org>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
>  arch/i386/Kconfig      |  304 ------------------------------------------------
>   arch/i386/Kconfig.cpu  |  305 ++++++++++++++++++++++++++++++++++++++++++++++++

Have mercy.  I currently have twelve patches which alter arch/i386/Kconfig
and this patch conflicts with most of them.  This shouldn't come as a
surprise - Kconfig files are oft-patched, and this is x86.

What I did was to simply copy the large block between

	if !X86_ELAN

and

	config X86_OOSTORE

over into Kconfig.cpu, taking the modifications with it.

As long as that's also what you did things should work OK.  If you actually
made any changes as you did the copy-and-paste, we're screwed.

