Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272308AbTG3Xq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272319AbTG3Xq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:46:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28876 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272308AbTG3XqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:46:25 -0400
Date: Wed, 30 Jul 2003 16:42:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC+PATCH] calling request_irq() with lock held (+sungem fix)
Message-Id: <20030730164252.300d272a.davem@redhat.com>
In-Reply-To: <1059586244.2420.41.camel@gaston>
References: <1059586244.2420.41.camel@gaston>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2003 13:30:44 -0400
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> i386 was sort-fixed by using GFP_ATOMIC in the kmalloc() done inside
> request_irq() itself, but what about all of the proc related stuff
> that gets done when setup_irq() calls register_irq_proc() ? So the
> _fact_ is that the current implementations in archs, including i386,
> are unsafe to call from "atomic" context.

That's true.

> David: this patch fixes sungem for that.

Ok, I'll review this and probably apply it, thanks.
