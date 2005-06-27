Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVF0GSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVF0GSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVF0GSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:18:07 -0400
Received: from mx1.suse.de ([195.135.220.2]:32130 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261827AbVF0GOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:14:16 -0400
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: jeffpc@optonline.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] Allocate kprobe_table at runtime
References: <20050626183049.GA22898@optonline.net.suse.lists.linux.kernel>
	<20050627055150.GA10659@in.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Jun 2005 08:14:12 +0200
In-Reply-To: <20050627055150.GA10659@in.ibm.com.suse.lists.linux.kernel>
Message-ID: <p737jggwcln.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:

> Jeff,
> 
> On Sun, Jun 26, 2005 at 06:37:29PM +0000, Jeff Sipek wrote:
> > Allocates kprobe_table at runtime.
> > -	/* FIXME allocate the probe table, currently defined statically */
> > +	kprobe_table = kmalloc(sizeof(struct hlist_head)*KPROBE_TABLE_SIZE, GFP_ATOMIC);
> 
> Memory allocation using GFP_KERNEL has more chances of success as compared to
> GFP_ATOMIC. Why can't we use GFP_KERNEL here?

I don't see any sense in the change anyways. Just using BSS 
should be fine.

Jeff, when you submit a patch you should add a small blurb
describing why you think it is a good idea.

-Andi
