Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279664AbRJ3AJk>; Mon, 29 Oct 2001 19:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279666AbRJ3AJb>; Mon, 29 Oct 2001 19:09:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24212 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279664AbRJ3AJW>;
	Mon, 29 Oct 2001 19:09:22 -0500
Date: Mon, 29 Oct 2001 16:04:52 -0800 (PST)
Message-Id: <20011029.160452.129079632.davem@redhat.com>
To: hugh@veritas.com
Cc: bcrl@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0110292358290.1036-100000@localhost.localdomain>
In-Reply-To: <20011029182949.H25434@redhat.com>
	<Pine.LNX.4.21.0110292358290.1036-100000@localhost.localdomain>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Tue, 30 Oct 2001 00:02:53 +0000 (GMT)
   
   But was the original flush_tlb_page() fully correct?  In i386 it's
   	if (vma->vm_mm == current->active_mm)
   		__flush_tlb_one(addr);
   without reference to whether vma->vm_mm is active on another cpu.
   
You're looking at the non-SMP version :-)

Franks a lot,
David S. Miller
davem@redhat.com
