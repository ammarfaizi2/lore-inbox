Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318114AbSHDAns>; Sat, 3 Aug 2002 20:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSHDAns>; Sat, 3 Aug 2002 20:43:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26803 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318114AbSHDAnr>;
	Sat, 3 Aug 2002 20:43:47 -0400
Date: Sat, 03 Aug 2002 17:34:02 -0700 (PDT)
Message-Id: <20020803.173402.73510247.davem@redhat.com>
To: frankeh@watson.ibm.com
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200208031653.39827.frankeh@watson.ibm.com>
References: <200208031441.29353.frankeh@watson.ibm.com>
	<15692.12781.344389.519591@napali.hpl.hp.com>
	<200208031653.39827.frankeh@watson.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hubertus Franke <frankeh@watson.ibm.com>
   Date: Sat, 3 Aug 2002 16:53:39 -0400

   Does that mean that BSD already has page coloring implemented ?
   
FreeBSD has had page coloring for quite some time.

Because they don't use buddy lists and don't allow higher-order
allocations fundamentally in the page allocator, they don't have
to deal with all the buddy fragmentation issues we do.

On the other hand, since higher-order page allocations are not
a fundamental operation it might be more difficult for FreeBSD
to implement superpage support efficiently like we can with
the buddy lists.
