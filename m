Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSFJEit>; Mon, 10 Jun 2002 00:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSFJEis>; Mon, 10 Jun 2002 00:38:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48309 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316617AbSFJEir>;
	Mon, 10 Jun 2002 00:38:47 -0400
Date: Sun, 09 Jun 2002 21:34:40 -0700 (PDT)
Message-Id: <20020609.213440.04716391.davem@redhat.com>
To: greearb@candelatech.com
Cc: mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D039D22.2010805@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Sun, 09 Jun 2002 11:23:30 -0700
   
   I need to account for packets on a per-session basis, where a
   session endpoint is a UDP port.  So, knowing global protocol numbers is
   good, but it is not very useful for the detailed accounting I
   need.

Why can't you just disable the other UDP services, and then there is
no question which UDP server/client is causing the drops.

Every argument I hear is one out of lazyness.  And that is not a
reason to add something.  Simply put, I don't want to add all of this
per-socket counter bumping that only, at best, 1 tenth of 1 percent
of people will use.  This means that the rest of the world eats the
overhead just for this small group that actually uses it.
