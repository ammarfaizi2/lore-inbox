Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284198AbRLFUSL>; Thu, 6 Dec 2001 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284181AbRLFUR7>; Thu, 6 Dec 2001 15:17:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41866 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284182AbRLFUQ3>;
	Thu, 6 Dec 2001 15:16:29 -0500
Date: Thu, 06 Dec 2001 12:15:54 -0800 (PST)
Message-Id: <20011206.121554.106436207.davem@redhat.com>
To: lm@bitmover.com
Cc: phillips@bonn-fries.net, davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206121004.F27589@work.bitmover.com>
In-Reply-To: <20011206115338.E27589@work.bitmover.com>
	<E16C4r8-0000r0-00@starship.berlin>
	<20011206121004.F27589@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 12:10:04 -0800

   Huh?  Of course not, they'd use mutexes in a mmap-ed file, which uses
   the hardware's coherency.  No locks in the vfs or fs, that's all done
   in the mmap/page fault path for sure, but once the data is mapped you
   aren't dealing with the file system at all.

We're talking about two things.

Once the data is MMAP'd, sure things are coherent just like on any
other SMP, for the user.

But HOW DID YOU GET THERE?  That is the question you are avoiding.
How do I look up "/etc/passwd" in the filesystem on a ccCluster?
How does OS image 1 see the same "/etc/passwd" as OS image 2?

If you aren't getting rid of this locking, what is the point?
That is what we are trying to talk about.
