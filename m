Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLOWAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTLOWAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:00:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:43977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264147AbTLOWAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:00:38 -0500
Date: Mon, 15 Dec 2003 14:00:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FDE1391.7030306@pobox.com>
Message-ID: <Pine.LNX.4.58.0312151359300.1631@home.osdl.org>
References: <3FDC9DC5.2070302@intel.com> <Pine.LNX.4.58.0312151023570.1488@home.osdl.org>
 <3FDE1391.7030306@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Jeff Garzik wrote:
>
> neat.  dumb question though...  how portable is set_fixmap_nocache()?

Not very. Although it should generally be trivial to port if you need it.

> I only see it on four architectures, and I'm sure PCI Express will
> appear on more than that eventually.

On 64-bit architectures you're not likely to ever need to worry about it,
and then you can just map the whole thing directly (and use some special
large-page mapping for it, at that).

		Linus
