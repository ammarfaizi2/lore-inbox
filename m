Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280818AbRKOM52>; Thu, 15 Nov 2001 07:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280819AbRKOM5S>; Thu, 15 Nov 2001 07:57:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25231 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280818AbRKOM5F>;
	Thu, 15 Nov 2001 07:57:05 -0500
Date: Thu, 15 Nov 2001 04:55:35 -0800 (PST)
Message-Id: <20011115.045535.99284023.davem@redhat.com>
To: viro@math.psu.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] pci/proc.c cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0111150100500.2244-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111150100500.2244-100000@weyl.math.psu.edu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alexander Viro <viro@math.psu.edu>
   Date: Thu, 15 Nov 2001 01:01:45 -0500 (EST)
   
   	It works here and applies both to 2.4.15-pre* and 2.4.13-ac*.
   Please, test - it's pretty straightforward and if there is no complaints
   I'm submitting that for inclusion into the tree.

I like this patch but I would change one thing.

"start,next,stop" sound like global kernel helper functions, not PCI
SEQ specific helpers, why not name them pci_seq_start et al. instead?

That pci_devices list does need locking, particularly with the PCI hot
plug stuff in the tree now.  But PCMCIA could already change the list
after boot too if I'm not mistaken.
