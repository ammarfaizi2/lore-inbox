Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSLFSMm>; Fri, 6 Dec 2002 13:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSLFSMm>; Fri, 6 Dec 2002 13:12:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43238 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265236AbSLFSMm>;
	Fri, 6 Dec 2002 13:12:42 -0500
Date: Fri, 06 Dec 2002 10:17:15 -0800 (PST)
Message-Id: <20021206.101715.113691767.davem@redhat.com>
To: adam@yggdrasil.com
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200212061619.IAA22144@baldur.yggdrasil.com>
References: <200212061619.IAA22144@baldur.yggdrasil.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Fri, 6 Dec 2002 08:19:25 -0800

   	Under the API addition that we've been discussing, the
   extra cache flushes and invalidations that these drivers need
   would become macros that would be expand to nothing on the
   other architectures, and the drivers would no longer have to
   have "if (consistent_alloation_failed) ..." branches around them.

Ok, but here is where my big concerns lie.

Specifically, it took years to get most developers confortable with
pci_alloc_consitent() and friends.  I totally fear that asking them to
now add cache flushing stuff to their drivers takes the complexity way
over the edge.

Willy, these PCXS/T processors sound like a newer cpu, do you mean to
tell me the caches are totally not coherent with device bus space?

Please elaborate, I want to learn more.
