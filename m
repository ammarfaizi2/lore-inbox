Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272484AbRI0MGZ>; Thu, 27 Sep 2001 08:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272493AbRI0MGP>; Thu, 27 Sep 2001 08:06:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272484AbRI0MGN>; Thu, 27 Sep 2001 08:06:13 -0400
Subject: Re: Locking comment on shrink_caches()
To: davem@redhat.com (David S. Miller)
Date: Thu, 27 Sep 2001 13:10:49 +0100 (BST)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, bcrl@redhat.com,
        marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010926.162655.79011481.davem@redhat.com> from "David S. Miller" at Sep 26, 2001 04:26:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ma09-0003p9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, this was my intended point.  Please see my quoted text above and
> note the "exclusive cache line acquisition" with emphasis on the word
> "acquisition" meaning you don't have the cache line in E state yet.

See prefetching - the CPU prefetching will hide some of the effect and
the spin_lock_prefetch() macro does wonders for the rest.

Alan

