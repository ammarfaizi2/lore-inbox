Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284942AbRLUQvT>; Fri, 21 Dec 2001 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284937AbRLUQvL>; Fri, 21 Dec 2001 11:51:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284940AbRLUQvG>; Fri, 21 Dec 2001 11:51:06 -0500
Subject: Re: [RFC] Scheduler queue implementation ...
To: pavel@suse.cz (Pavel Machek)
Date: Fri, 21 Dec 2001 17:01:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20011220203630.A204@elf.ucw.cz> from "Pavel Machek" at Dec 20, 2001 08:36:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HT2l-0000oP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd guess that if cpu-bound software wants to use clone(CLONE_VM) to
> gain some performance, it should better work "mostly" in different
> memory areas on different cpus... But I could be wrong.

Lots of people use shared mm objects and threads for things like UI rather
than just for cpu hogging. If they have multiple cpu hogs doing that then
they want punishing (or better yet sending a copy of a document on caches)
