Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270909AbRHNWmr>; Tue, 14 Aug 2001 18:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270912AbRHNWmh>; Tue, 14 Aug 2001 18:42:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45188 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270907AbRHNWmc>;
	Tue, 14 Aug 2001 18:42:32 -0400
Date: Tue, 14 Aug 2001 15:42:33 -0700 (PDT)
Message-Id: <20010814.154233.98555395.davem@redhat.com>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15Wmp0-00056i-00@gondolin.me.apana.org.au>
In-Reply-To: <20010814.144347.95061445.davem@redhat.com>
	<E15Wmp0-00056i-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Herbert Xu <herbert@gondor.apana.org.au>
   Date: Wed, 15 Aug 2001 08:38:02 +1000

   Hmm, it still seems to be wrong:
 ...

           if (nfds > current->files->max_fds)
                   nfds = current->files->max_fds;
   
   The second if statement should be removed.  And it might be better to use
   current->rlim[RLIMIT_NOFILE].rlim_cur instead of NR_OPEN.

It has to be limited to "max_fds", that is how many files we may
legally address in current->files!

Later,
David S. Miller
davem@redhat.com
