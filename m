Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758091AbWK2VNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091AbWK2VNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758088AbWK2VNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:13:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:26032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758091AbWK2VNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:13:14 -0500
Date: Wed, 29 Nov 2006 13:09:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephane Eranian <eranian@hpl.hp.com>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [PATCH] i386 add idle notifier
Message-Id: <20061129130944.82e3d9bb.akpm@osdl.org>
In-Reply-To: <20061129170939.GA29203@infradead.org>
References: <20061129162540.GL28007@frankl.hpl.hp.com>
	<20061129170939.GA29203@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 17:09:39 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 29, 2006 at 08:25:40AM -0800, Stephane Eranian wrote:
> > Hello,
> > 
> > Here is a patch that adds an idle notifier to the i386 tree.
> > The idle notifier functionalities and implementation are
> > identical to the x86_64 idle notifier. We use the idle notifier
> > in the context of perfmon.
> > 
> > The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
> > kernel. It may apply to other kernels but it needs some updates
> > to poll_idle() and default_idle() to work correctly.
> 
> Walking through a notifier chain on every single interrupt (including
> timer interrupts) seems rather costly.  What do you need this for
> exactly?

yes, it's a worry.

Why doesn't enter_idle() do the test_and_set_bit() thing, like
exit_idle()?
