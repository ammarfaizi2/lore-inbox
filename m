Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSG2FvE>; Mon, 29 Jul 2002 01:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSG2FvE>; Mon, 29 Jul 2002 01:51:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2532 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318031AbSG2FvD>;
	Mon, 29 Jul 2002 01:51:03 -0400
Date: Sun, 28 Jul 2002 22:43:02 -0700 (PDT)
Message-Id: <20020728.224302.36837419.davem@redhat.com>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207282117030.1003-100000@home.transmeta.com>
References: <20020728.204302.44950225.davem@redhat.com>
	<Pine.LNX.4.44.0207282117030.1003-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 28 Jul 2002 21:21:12 -0700 (PDT)
   
   But the thing is, nobody should normally have a reference to such a
   page anyway. The only way they happen is by something mapping a
   page from user space, and saving it away, while the user space goes
   away and drops its references to the page.

Ignoring for a moment whether you agree with the idea of zero-copying
userspace pages over sockets, I would at least like to retain the
ability to experiment with something like this.

I'm not all that opposed to Andrew's described scheme of making the
LRU lock IRQ safe.  And it would allow one to experiment with
userpage socket zerocopy.

