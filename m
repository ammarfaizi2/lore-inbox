Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSFJEbY>; Mon, 10 Jun 2002 00:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFJEbX>; Mon, 10 Jun 2002 00:31:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36533 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316548AbSFJEbW>;
	Mon, 10 Jun 2002 00:31:22 -0400
Date: Sun, 09 Jun 2002 21:27:05 -0700 (PDT)
Message-Id: <20020609.212705.00004924.davem@redhat.com>
To: paulus@samba.org
Cc: roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Sun, 9 Jun 2002 19:51:58 +1000 (EST)

   This is the problem scenario.  Suppose we are doing DMA to a buffer B
   and also independently accessing a variable X which is not part of B.
   Suppose that X and the beginning of B are both in cache line C.
   
I see what the problem is.  Hmmm...

I'm trying to specify this such that knowledge of cachelines and
whatnot don't escape the arch specific code, ho hum...  Looks like
that isn't possible.
