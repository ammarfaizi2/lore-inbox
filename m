Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132934AbRDEPqV>; Thu, 5 Apr 2001 11:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRDEPqM>; Thu, 5 Apr 2001 11:46:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23936 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132935AbRDEPqB>;
	Thu, 5 Apr 2001 11:46:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15052.37635.264641.436756@pizda.ninka.net>
Date: Thu, 5 Apr 2001 08:45:07 -0700 (PDT)
To: "Steve Grubb" <ddata@gate.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <001701c0bde4$59825240$871a24cf@master>
In-Reply-To: <001701c0bde4$59825240$871a24cf@master>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve Grubb writes:
 > It would seem to me that after hearing how the macros are used in practice,
 > wouldn't turning them into inline functions be an improvement? This is
 > something gcc supports, it accomplishes the same thing, and has the added
 > advantage of type checking.
 > http://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_4.html#SEC92

Two reasons:

1) Sometimes I don't want any type checking because it would create
   the necessity of adding a new include to a file --> a circular
   dependency to resolve.  Macros hide the types except in the
   cases where they are actually invoked :-)

2) Historically GCC was very bad with code generation with inline
   functions, so at that time the GCC manual statement "inline
   functions are just like a macro" was technically false :-)

   Yes, I know this is much different in today's gcc tree, but
   there hasn't been a gcc release in over 2 years so...

Later,
David S. Miller
davem@redhat.com
