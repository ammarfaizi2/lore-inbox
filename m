Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSLFS0s>; Fri, 6 Dec 2002 13:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbSLFS0s>; Fri, 6 Dec 2002 13:26:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53478 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264945AbSLFS0r>;
	Fri, 6 Dec 2002 13:26:47 -0500
Date: Fri, 06 Dec 2002 10:31:13 -0800 (PST)
Message-Id: <20021206.103113.98609883.davem@redhat.com>
To: James.Bottomley@steeleye.com
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212061829.gB6ITAt03038@localhost.localdomain>
References: <davem@redhat.com>
	<200212061829.gB6ITAt03038@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@steeleye.com>
   Date: Fri, 06 Dec 2002 12:29:10 -0600

   How about (as Adam suggested) two dma allocation API's
   
   1) dma_alloc_consistent which behaves identically to pci_alloc_consistent
   2) dma_alloc which can take the conformance flag and can be used to tidy up 
   the drivers that need to know about cache flushing.
   
Now that the situation is much more clear, I'm feeling a lot
better about this.

I have only one request, in terms of naming.  What we're really
doing is adding a third class of memory, it really isn't consistent
and it really isn't streaming.  It's inconsistent memory meant to
be used for "consistent memory things".

So could someone come up with a clever name for this thing? :-)
