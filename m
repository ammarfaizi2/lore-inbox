Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSFONjv>; Sat, 15 Jun 2002 09:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSFONju>; Sat, 15 Jun 2002 09:39:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315372AbSFONjt>;
	Sat, 15 Jun 2002 09:39:49 -0400
Date: Sat, 15 Jun 2002 06:35:06 -0700 (PDT)
Message-Id: <20020615.063506.12172725.davem@redhat.com>
To: linux-kernel@vger.kernel.org, Thomas.Duffy.99@alumni.brown.edu
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <AFARA-EXi6YEFmsQSkt00002356@afara-ex.afara.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Thomas Duffy" <Thomas.Duffy.99@alumni.brown.edu>
   Date: Fri, 14 Jun 2002 15:00:03 -0700

   This part of the patch (the change to kernel/sched.c) can be safely	
   removed without making o1 stop working.
   
If Ingo's changes to remove the "frozen" stuff is installed, the
kernel is going to hang when you hit the deadlock condition on
sparc64.  Unless I'm mistaken, the "frozen" stuff had been removed.

You are going to hit this deadlock which I mentioned in another thread
on this list when Ingo mentioned that he had removed the "frozen"
locking I added because it causes other problems.
