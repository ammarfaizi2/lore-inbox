Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSIAK7t>; Sun, 1 Sep 2002 06:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSIAK7t>; Sun, 1 Sep 2002 06:59:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54465 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316672AbSIAK7p>;
	Sun, 1 Sep 2002 06:59:45 -0400
Date: Sun, 01 Sep 2002 03:57:49 -0700 (PDT)
Message-Id: <20020901.035749.37156689.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901105643.GH32122@louise.pinerecords.com>
References: <20020901105643.GH32122@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sun, 1 Sep 2002 12:56:43 +0200

   2.4.20-pre5: prevent sparc32's atomic_read() from possibly discarding
   const qualifiers from pointers passed as its argument.
   
   -static __inline__ int atomic_read(atomic_t *v)
   +static __inline__ int atomic_read(const atomic_t *v)

So the atomic_t is const is it?  That's news to me.

I think you mean something like "atomic_t const * v" which means the
pointer is constant, not the value.
