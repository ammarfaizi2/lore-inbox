Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316181AbSETSHm>; Mon, 20 May 2002 14:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSETSHl>; Mon, 20 May 2002 14:07:41 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:992 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316181AbSETSHk>;
	Mon, 20 May 2002 14:07:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.15196.98387.461937@napali.hpl.hp.com>
Date: Mon, 20 May 2002 11:07:24 -0700
To: Sanket Rathi <sanket.rathi@cdac.ernet.in>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <Pine.GSO.4.10.10205162118380.10635-100000@mailhub.cdac.ernet.in>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 16 May 2002 21:24:10 +0530 (IST), Sanket Rathi <sanket.rathi@cdac.ernet.in> said:

  Sanket> No actually i don't want that for DMA it is for diffrent
  Sanket> requirment.  actually in our device there is a page table in
  Sanket> device which have virtual to physical address translation we
  Sanket> save virtual address in device and corresponding physical
  Sanket> address. but we can store only upto 44 bit information of
  Sanket> virtual address thats why i want that.

  Sanket> Can you help me in this

There is no way to limit virtual memory to 44 bits.  I don't know how
your device works, but just fyi: ia64 divides the address space into 8
equal-sized regions and user space applications tend to use at least
two regions (2 for text and 3 for data/stack).  This means that even
with the smallest page size, you'll have to take virtual address bits
61-63 into account.

Hope this helps,

	--david
--
Interested in learning more about IA-64 Linux?  Try http://www.lia64.org/book/
