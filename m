Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270943AbRHNXzx>; Tue, 14 Aug 2001 19:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270949AbRHNXze>; Tue, 14 Aug 2001 19:55:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37509 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270943AbRHNXzZ>;
	Tue, 14 Aug 2001 19:55:25 -0400
Date: Tue, 14 Aug 2001 16:53:20 -0700 (PDT)
Message-Id: <20010814.165320.77058794.davem@redhat.com>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B79BA07.B57634FD@sun.com>
In-Reply-To: <3B79B5F3.C816CBED@sun.com>
	<20010814.163804.66057702.davem@redhat.com>
	<3B79BA07.B57634FD@sun.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Hockin <thockin@sun.com>
   Date: Tue, 14 Aug 2001 16:53:43 -0700

   The standard says negative fd's are ignored.  We get that right.  What we
   are left with is an overly paranoid check against max_fds.  This check
   should go away.  You should be able to pass in up to your rlimit fds, and
   let negative ones (holes or tails) be ignored.
   
I am saying there is no problem.

In both cases, for a properly written application we ignore the
invalid fds.  The behavior is identical both before and after
your change, so there is no reason to make it.

Later,
David S. Miller
davem@redhat.com

