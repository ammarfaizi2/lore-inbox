Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSEMBCz>; Sun, 12 May 2002 21:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEMBCz>; Sun, 12 May 2002 21:02:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48852 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315358AbSEMBCx>;
	Sun, 12 May 2002 21:02:53 -0400
Date: Sun, 12 May 2002 17:50:21 -0700 (PDT)
Message-Id: <20020512.175021.50367158.davem@redhat.com>
To: torvalds@transmeta.com
Cc: wrose@loislaw.com, linux-kernel@vger.kernel.org
Subject: Re: Segfault hidden in list.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205121750530.15392-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sun, 12 May 2002 17:59:27 -0700 (PDT)
   
   If the coder doesn't lock his data structures, it doesn't matter _what_
   order we execute the list modifications in - different architectures will
   do different thing with inter-CPU memory ordering, and trying to order
   memory accesses on a source level is futile.

However, if the list manipulation had some memory barriers
added to it...

The people doing the lockless reader RCU stuff could benefit from such
an interface.
