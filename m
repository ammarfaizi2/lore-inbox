Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWIJWAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWIJWAh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWIJWAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:00:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23680 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932080AbWIJWAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:00:36 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       segher@kernel.crashing.org
In-Reply-To: <1157923513.31071.256.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 23:23:13 +0100
Message-Id: <1157926993.23085.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 07:25 +1000, ysgrifennodd Benjamin Herrenschmidt:
> I'm copying that from a private discussion I had. Please let me know if
> you have comments. This proposal includes some questions too so please
> answer :)

Looks sane and Linus seems to like mmiowb. Only other question: what are
the guarantees of memcpy_to/fromio. Does it access the memory in ordered
fashion or not, does it guarantee only ordering at the end of the copy
or during it ?

