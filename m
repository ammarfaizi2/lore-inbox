Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275007AbTHLCwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275010AbTHLCwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:52:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275007AbTHLCws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:52:48 -0400
Date: Mon, 11 Aug 2003 19:46:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, yoshfuji@linux-ipv6.org,
       jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: virt_to_offset()
Message-Id: <20030811194606.307a1606.davem@redhat.com>
In-Reply-To: <16183.56997.123977.527982@napali.hpl.hp.com>
References: <20030810081529.GX31810@waste.org>
	<20030810.173215.102258218.yoshfuji@linux-ipv6.org>
	<20030810013041.679ddc4c.davem@redhat.com>
	<20030810.180241.71795022.yoshfuji@linux-ipv6.org>
	<16183.56997.123977.527982@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 11:21:25 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> It's a bad choice of name.  X_to_Y() normally implies that X and Y are
> basically different representations of the same thing (e.g., a page
> pointer vs. a virtual address).  However, virt_to_pageoff() is a
> one-way translation, so it's misleading.

By your arguments, virt_to_page() is also misnamed.  It is not possible
to take the page pointer result and use that to get back to the virtual
address input to virt_to_page().

I think as a first step, it's more important to have consistent names
for the two translation routines used.

As a secondary step, we can fix virt_to_*() naming, as appropriate.

Ok?
