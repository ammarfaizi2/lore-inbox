Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbSKLVr3>; Tue, 12 Nov 2002 16:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbSKLVr2>; Tue, 12 Nov 2002 16:47:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54464 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266982AbSKLVqr>;
	Tue, 12 Nov 2002 16:46:47 -0500
Date: Tue, 12 Nov 2002 13:51:47 -0800 (PST)
Message-Id: <20021112.135147.21135668.davem@redhat.com>
To: hugh@veritas.com
Cc: akpm@digeo.com, dmccr@us.ibm.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0211121732170.1187-100000@localhost.localdomain>
References: <20021111.225333.122204472.davem@redhat.com>
	<Pine.LNX.4.44.0211121732170.1187-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Tue, 12 Nov 2002 17:43:40 +0000 (GMT)
   
   Sorry, I still don't get it.  If the flush_cache_page is doing something
   necessary, then won't a user access in between it and invalidating pte
   undo what was necessary?  And if it's not necessary, why do we do it?
   (For better performance would be a very good reason.)
   
If there are other writable mappings of the page, we can't swap
it out legally.
