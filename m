Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTFXPrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTFXPrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:47:10 -0400
Received: from ns.suse.de ([213.95.15.193]:58888 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262066AbTFXPrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:47:05 -0400
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes for 2.5.73 with single-stepping out-of-line
References: <20030624140926.A17908@in.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Jun 2003 18:01:09 +0200
In-Reply-To: <20030624140926.A17908@in.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73n0g74g8q.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vamsi Krishna S ." <vamsi@in.ibm.com> writes:


> +static struct kprobe *current_kprobe;

This global variable is quite unclean. It looks like it is for passing
function arguments around. Why is it needed? 

> +#define KPROBE_HASH_BITS 6
> +#define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> +
> +static struct list_head kprobe_table[KPROBE_TABLE_SIZE];

Use hlists?


-Andi
