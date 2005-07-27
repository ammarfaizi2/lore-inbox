Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVG0XJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVG0XJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVG0XGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:06:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVG0XEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:04:54 -0400
Date: Wed, 27 Jul 2005 16:03:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: mporter@kernel.crashing.org, wfarnsworth@mvista.com,
       linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] ppc32: add 440ep support
Message-Id: <20050727160315.02df6a75.akpm@osdl.org>
In-Reply-To: <17128.4407.838024.111955@cargo.ozlabs.ibm.com>
References: <11224856623638@foobar.com>
	<20050727131857.78a56972.akpm@osdl.org>
	<17128.4407.838024.111955@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Andrew Morton writes:
> 
> > Matt Porter <mporter@kernel.crashing.org> wrote:
> > >
> > > +static u64 dma_mask = 0xffffffffULL;
> > 
> > I'm sure you're totally uninterested in this, but the above will probably
> > generate warnings on (say) ppc64, where u64 is implemented as unsigned
> > long.
> > 
> > I usually chuck a simple `-1' in there and the compiler always gets it
> > right, regardless of signedness and size and architecture.
> 
> Umm, I think we actually want 2^32-1 not -1, don't we?

Doh.  Cant coun't.

