Return-Path: <linux-kernel-owner+willy=40w.ods.org-S292702AbUKBA17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S292702AbUKBA17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270498AbUKBA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:27:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:51160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270329AbUKBAZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:25:34 -0500
Date: Mon, 1 Nov 2004 16:29:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: dhowells@redhat.com
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info
Message-Id: <20041101162929.63af1d0d.akpm@osdl.org>
In-Reply-To: <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com>
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	<200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhowells@redhat.com wrote:
>
> The attached patch permits the generation of more useful debugging information
> by reducing the optimisation level and by telling the assembler to produce
> debug info too.

Generates rejects against Sam's tree and appears to be unrelated to FRV,
yes?

I'd prefer that this be worked through Sam's tree as a separate enhancement
please.


+ifdef CONFIG_DEBUG_INFO
+CFLAGS		+= -g -O1
+AFLAGS		+= -Wa,--gdwarf2
+ASFLAGS		+= -Wa,--gdwarf2
+else

Are you sure that all architectures want this?  And that their toolchains
will continue to work correctly?  And that it doesn't break older gcc's and
that kgdb will continue to work correctly, etc?

I'm not...
