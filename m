Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWARMWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWARMWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWARMWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:22:23 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:38056 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030303AbWARMWW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:22:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ADehFDAmpPahwPoaygNYgVqmwpC+OWNuo0Pwv/WoPCt64dqjWtyCUa0Y0VY1FkAd1Nf/tvaJj92c5XmqeMMkfqiQ+6JekwZ+y1f3SzsNEQc+9aOHo+TjJpfUXA+/dbUbYNP/bCtb3H98kuUr0j7fzeFmo3hzOD3vMuDm39h0h/k=
Message-ID: <84144f020601180422q78ecdf37mb8b8e9d1f40039d1@mail.gmail.com>
Date: Wed, 18 Jan 2006 14:22:19 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Sven Lauritzen <the-pulse@gmx.net>
Subject: Re: [BUG] at mm/slab.c:1235! (Version 2.6.15)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137582956.1774.15.camel@berlin.slsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1137582956.1774.15.camel@berlin.slsd>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/18/06, Sven Lauritzen <the-pulse@gmx.net> wrote:
> Last night my machine crashed and I found this report in the syslog.
> Kernel version is 2.6.15 vanilla. I've pasted .config and lspci -vvv
> output. Please let me know if you need more information. I hope this is
> the right place to drop the report.

Try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC to see if
they pick up anything.

On 1/18/06, Sven Lauritzen <the-pulse@gmx.net> wrote:
> Jan 18 06:27:16 berlin kernel: kernel BUG at mm/slab.c:1235!
> Jan 18 06:27:16 berlin kernel: invalid operand: 0000 [#1]
> Jan 18 06:27:16 berlin kernel: PREEMPT
> Jan 18 06:27:16 berlin kernel: Modules linked in: snd_ens1371
> snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi
> snd_seq_midi_event snd_seq snd_seq_device snd_ac97_bus
> Jan 18 06:27:16 berlin kernel: CPU:    0
> Jan 18 06:27:16 berlin kernel: EIP:    0060:[<c013f4bd>]    Not tainted
> VLI
> Jan 18 06:27:16 berlin kernel: EFLAGS: 00010046   (2.6.15)
> Jan 18 06:27:16 berlin kernel: EIP is at kmem_freepages+0x3d/0xa0

I don't quite see how this could happen. Is the box otherwise stable?
Have you run memtest86 on it?

                             Pekka
