Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVG0UZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVG0UZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVG0UXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:23:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262440AbVG0UUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:20:24 -0400
Date: Wed, 27 Jul 2005 13:18:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: wfarnsworth@mvista.com, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] ppc32: add 440ep support
Message-Id: <20050727131857.78a56972.akpm@osdl.org>
In-Reply-To: <11224856623638@foobar.com>
References: <11224856623638@foobar.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> +static u64 dma_mask = 0xffffffffULL;

I'm sure you're totally uninterested in this, but the above will probably
generate warnings on (say) ppc64, where u64 is implemented as unsigned
long.

I usually chuck a simple `-1' in there and the compiler always gets it
right, regardless of signedness and size and architecture.
