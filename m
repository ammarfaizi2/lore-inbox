Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278963AbRJVVla>; Mon, 22 Oct 2001 17:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278964AbRJVVkQ>; Mon, 22 Oct 2001 17:40:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8577 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278965AbRJVVjn>;
	Mon, 22 Oct 2001 17:39:43 -0400
Date: Mon, 22 Oct 2001 14:39:58 -0700 (PDT)
Message-Id: <20011022.143958.78707983.davem@redhat.com>
To: bcrl@redhat.com
Cc: alan@lxorguk.ukuu.org.uk, hawkes@oss.sgi.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011022165157.M23213@redhat.com>
In-Reply-To: <20011022161527.K23213@redhat.com>
	<E15vlx2-0003HO-00@the-village.bc.nu>
	<20011022165157.M23213@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 22 Oct 2001 16:51:57 -0400

   On Mon, Oct 22, 2001 at 09:45:36PM +0100, Alan Cox wrote:
   > > Please reject this patch.  The gcc folks are wrong in this case.
   > 
   > Im curious - why do you make that specific claim. The multiline literals are
   > rather ugly.
   
   Which of the following is more readable:
   
   /* try atomic lock inline, if that fails, spin out of line */
   	"\tbtsl $1,%0\n"

It's only gross because you decided to make it so, try:

   	"btsl $1,%0\n\t"

Which is what I use just about everywhere now and I'm prefectly
fine with it.

Franks a lot,
David S. Miller
davem@redhat.com
