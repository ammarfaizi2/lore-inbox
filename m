Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277724AbRJIF4A>; Tue, 9 Oct 2001 01:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277725AbRJIFzu>; Tue, 9 Oct 2001 01:55:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1675 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277724AbRJIFzm>;
	Tue, 9 Oct 2001 01:55:42 -0400
Date: Mon, 08 Oct 2001 22:56:10 -0700 (PDT)
Message-Id: <20011008.225610.94885115.davem@redhat.com>
To: Paul.McKenney@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        rth@redhat.com
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF2F33BD66.440BE6A1-ON88256AE0.001DFF26@boulder.ibm.com>
In-Reply-To: <OF2F33BD66.440BE6A1-ON88256AE0.001DFF26@boulder.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
   Date: Mon, 8 Oct 2001 22:27:44 -0700
   
   All other CPUs must observe the preceding stores before the following
   stores.
 ...
   Does this do the trick?
   
              membar #StoreStore
   
Yes.

   The IPIs and related junk are I believe needed only on Alpha, which has
   no single memory-barrier instruction that can do wmbdd()'s job.  Given
   that Alpha seems to be on its way out, this did not seem to me to be
   too horrible.
   
I somehow doubt that you need an IPI to implement the equivalent of
"membar #StoreStore" on Alpha.  Richard?

Franks a lot,
David S. Miller
davem@redhat.com
