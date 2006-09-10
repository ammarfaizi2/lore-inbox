Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWIJAPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWIJAPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWIJAPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:15:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49302 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965045AbWIJAPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:15:30 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, mchan@broadcom.com,
       segher@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <1157841367.31071.182.camel@localhost.localdomain>
References: <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
	 <1157745256.5344.8.camel@rh4>
	 <1157751962.31071.102.camel@localhost.localdomain>
	 <20060909.022228.41644790.davem@davemloft.net>
	 <1157841367.31071.182.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 01:38:18 +0100
Message-Id: <1157848698.6877.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-09-10 am 08:36 +1000, ysgrifennodd Benjamin Herrenschmidt:
> Well, some of you (Alan, you, etc...) seem to imply that it's always
> been the rule to have a memory store followed by an MMIO write be
> strongly ordered.

It has always been the rule

> However, if you look at drivers like e1000, USB OHCI, or even sungem
> (:-) they, all have at least wmb()'s between updating descriptor in

Driver hacks to cope with platform authors who got read/writel wrong.

> semantics. At least what is implemented currently on PowerPC is the
> __raw_* versions which not only have no barriers at all (they don't even
> order between MMIOs, for example, readl might cross writel), and do no
> endian swap. Quite a mess of semantics if you ask me... Then there has

__writel/__readl seems more in keeping for just not locking.


