Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275311AbRIZQg6>; Wed, 26 Sep 2001 12:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275309AbRIZQgt>; Wed, 26 Sep 2001 12:36:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45572 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275313AbRIZQgm>; Wed, 26 Sep 2001 12:36:42 -0400
Subject: Re: Locking comment on shrink_caches()
To: davem@redhat.com (David S. Miller)
Date: Wed, 26 Sep 2001 17:40:15 +0100 (BST)
Cc: bcrl@redhat.com, marcelo@conectiva.com.br, andrea@suse.de,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010925.152858.00453513.davem@redhat.com> from "David S. Miller" at Sep 25, 2001 03:28:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mHjL-0000t8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Ahh, that's a cpu bug -- one my athlons don't suffer from.
>    
> Your Athlons may handle exclusive cache line acquisition more
> efficiently (due to memory subsystem performance) but it still
> does cost something.

On an exclusive line on Athlon a lock cycle is near enough free, its 
just an ordering constraint. Since the line is in E state no other bus
master can hold a copy in cache so the atomicity is there. Ditto for newer
Intel processors
