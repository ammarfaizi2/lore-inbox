Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWGaEet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWGaEet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWGaEet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:34:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751234AbWGaEes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:34:48 -0400
Date: Sun, 30 Jul 2006 21:34:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Coulson <david@davidcoulson.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at net/core/dev.c:1171/skb_checksum_help()
 2.6.18-rc3
Message-Id: <20060730213437.e2ce619d.akpm@osdl.org>
In-Reply-To: <44CD8415.2020403@davidcoulson.net>
References: <44CD8415.2020403@davidcoulson.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 00:16:21 -0400
David Coulson <david@davidcoulson.net> wrote:

> This machine has four NICs running the e1000 kernel module. Other than
> the BUG() messages, it seems to be running fine. I was running 2.6.15.4
> without any issues on the same hardware, although I noticed the e1000
> has been updated (and I went for rc3 since I was hitting the panic in -rc2)
> 
> Now, I'm not sure if it also has anything to do with this message:
> 
> NAT: no longer support implicit source local NAT
> NAT: packet src 10.1.1.1 -> dst 207.166.203.131
> 
> Any suggestions as to how to go about debugging this?
> 
> BUG: warning at net/core/dev.c:1171/skb_checksum_help()
>  [<c02e0412>] skb_checksum_help+0x4d/0xf0
>  [<c034e4d3>] ip_nat_fn+0x4e/0x19e
>  [<c034e78e>] ip_nat_local_fn+0x3d/0xb9
>  [<c0314011>] dst_output+0x0/0x7
>  [<c03059ee>] nf_iterate+0x40/0x6e

Several people are reporting this.  It's apparently harmless and serves as
a(n odd) way for the net guys to remind themselves that this needs fixing.

It'd be nice to not let this escape into 2.6.18, please?
