Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289065AbSAVALH>; Mon, 21 Jan 2002 19:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSAVAK6>; Mon, 21 Jan 2002 19:10:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10674 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289065AbSAVAKs>;
	Mon, 21 Jan 2002 19:10:48 -0500
Date: Mon, 21 Jan 2002 16:08:53 -0800 (PST)
Message-Id: <20020121.160853.10161323.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent from interrupt == BAD
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201212352.g0LNq5802844@devserv.devel.redhat.com>
In-Reply-To: <3C4875DB.9080402@embeddededge.com>
	<mailman.1011386221.24072.linux-kernel2news@redhat.com>
	<200201212352.g0LNq5802844@devserv.devel.redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Mon, 21 Jan 2002 18:52:05 -0500

   > It [GFP_HIGH] is a trivial fix whereas backing
   > out this ability to call pci_alloc_consistent from interrupts is not
   > a trivial change at all.
   
   David, would you make a statement about pci_free_consistent.
   I find it annoying that it cannot be called from an interrupt.
   
It is not an unreasonable requirement.  Wasn't there some problem with
the pci pool stuff if it free'd up a chunk in an interrupt?
