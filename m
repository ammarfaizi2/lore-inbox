Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312187AbSCRDL0>; Sun, 17 Mar 2002 22:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312186AbSCRDLH>; Sun, 17 Mar 2002 22:11:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15034 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312184AbSCRDK7>;
	Sun, 17 Mar 2002 22:10:59 -0500
Date: Sun, 17 Mar 2002 19:07:45 -0800 (PST)
Message-Id: <20020317.190745.113101138.davem@redhat.com>
To: paulus@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15507.12988.581489.554212@argo.ozlabs.ibm.com>
In-Reply-To: <E16la2m-0000SX-00@starship>
	<a6te11$si7$1@penguin.transmeta.com>
	<15507.12988.581489.554212@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Sat, 16 Mar 2002 22:55:40 +1100 (EST)
   
   IMHO it would be interesting to compare the size and complexity of
   using a hash table for the page tables with a 5-level tree.  For a
   32-bit address space I think the tree wins hands down but for a full
   64-bit address space I am not convinced either way at present.

You only need a 4-level tree for a full 64-bit address space as long
as you can guarentee less than (32 + PAGE_SHIFT) bits of physical
addressing (ie. you can use 32-bit pmd_t's and pgd_t's in that case).

At least this is how I remember the numbers working out.
