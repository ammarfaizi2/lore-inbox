Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289527AbSAOMlL>; Tue, 15 Jan 2002 07:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289533AbSAOMlB>; Tue, 15 Jan 2002 07:41:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15522 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289527AbSAOMkt>;
	Tue, 15 Jan 2002 07:40:49 -0500
Date: Tue, 15 Jan 2002 04:39:11 -0800 (PST)
Message-Id: <20020115.043911.21332087.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: peter@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16QSxC-0004yp-00@the-village.bc.nu>
In-Reply-To: <20020115025840.11509.qmail@science.horizon.com>
	<E16QSxC-0004yp-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 15 Jan 2002 12:44:38 +0000 (GMT)
   
   If at boot time we keep a big chunk of ram free at the kernel end and just
   load modules one after each other into that space until we get into real
   paging that problem goes away

And we do have module_map/module_unmap interfaces already so it's
easy to toy with this.

I've always been meaning to do a "alloc 4MB page at boot, lock into
TLB, carve module pages out of that, vmalloc when that runs out" on
sparc64.
