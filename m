Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVLNCko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVLNCko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 21:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVLNCko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 21:40:44 -0500
Received: from ns.suse.de ([195.135.220.2]:29847 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751185AbVLNCkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 21:40:43 -0500
Date: Wed, 14 Dec 2005 03:40:37 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] sanitize building of fs/compat_ioctl.c
Message-ID: <20051214024037.GC23384@wotan.suse.de>
References: <20051213173434.GP9286@parisc-linux.org> <20051213.145109.20744871.davem@davemloft.net> <p73r78g8nft.fsf@verdi.suse.de> <20051213.182340.102535288.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213.182340.102535288.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suppose.  We could also funnel down ->compat_{read,write}() and
> so on down the call chain, but that would likely be even uglier.

The problem is that this would need to be done for all variants
(write, writev, aio_write, send{,msg,to} etc.) Same for read. I probably forgot
one or two. 


> I guess with is_compat_task() we can do the netlink and pfkeyv2 compat
> stuff on ia64/x86_64.  I don't look forward to reviewing a patch
> implementing that, however :-/

And iptables, although that would be probably *really* ugly.
It's a bit of a sore spot on x86-64 though. 64bit kernel with full
32bit userland works usually great except for iptables and ipsec.

-Andi
