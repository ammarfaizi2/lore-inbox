Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTK3S7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTK3S7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:59:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47755 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262789AbTK3S7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:59:06 -0500
Date: Sun, 30 Nov 2003 10:58:29 -0800
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 and CONFIG_PROC_FS=n
Message-Id: <20031130105829.478e408a.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0311301949180.23461-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0311301949180.23461-100000@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Nov 2003 19:55:48 +0100 (MET)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> 
> When compiling 2.4.23 with CONFIG_PROC_FS disabled, I found a few
> network-related files that don't compile:
>   1. net/atm/br2684.c 
>   2. net/core/pktgen.c
>   3. net/ipv4/netfilter/ipt_recent.c
> 
> The patch below fixes 1 and 3. Note that 3 still generates a compiler warning
> (`ip_list_perms' defined but not used).

Thanks Geert, I'll review and probably apply this.

> The packet generator is a bit trickier, since its functionality seems to
> depend completely on the proc file system.

Yes, it does, should just add the dependency to the config.

Thanks again.
