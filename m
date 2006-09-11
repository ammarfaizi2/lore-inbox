Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWIKVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWIKVee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWIKVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:34:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:17843 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750785AbWIKVee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:34:34 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1157995595.23085.194.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
	 <1157969261.23085.108.camel@localhost.localdomain>
	 <1157968778.3879.41.camel@localhost.localdomain>
	 <1157995595.23085.194.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 07:29:58 +1000
Message-Id: <1158010198.3879.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 18:26 +0100, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 19:59 +1000, ysgrifennodd Benjamin Herrenschmidt:
> > Ok, so we would define ordering on the first and last accesses (being
> > the first and last in ascending addresses order) and leave it free to
> > the implementation to do what it wants in between. Is that ok ?
> 
> Not sure you can go that far. I'd stick to "_fromio/_toio" transfer
> blocks of data efficiently between host and bus addresses. The
> guarantees are the same as readl/writel respectively with respect to the
> start and end of the transfer.
> 
> [How do you define start and end addresses with memcpy_fromio(foo, bar,
> 4) for example ]

Ok. So they behave like a writel or a readl globally respective to other
accesses but there is no guarantee in order or size of the individual
transfers making them up.

Ben


