Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSEIO3D>; Thu, 9 May 2002 10:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSEIO3C>; Thu, 9 May 2002 10:29:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20916 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313173AbSEIO3C>;
	Thu, 9 May 2002 10:29:02 -0400
Date: Thu, 09 May 2002 07:16:58 -0700 (PDT)
Message-Id: <20020509.071658.130422008.davem@redhat.com>
To: hugh@veritas.com
Cc: andrea@suse.de, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0205091446070.10938-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Thu, 9 May 2002 14:50:11 +0100 (BST)
   
   Agreed.  It's better to keep flush_page_to_ram out of filemap_nopage
   (and how many other _nopages that ought at present to have it according
   to David, but don't).  As things stand, it's being done unnecessarily
   twice on the shared maps: your proposal fixes that.

There are many other cases where flush_page_to_ram overflushes,
its deficiencies are known.

This is why I am suggesting "don't touch this in 2.4 and let's
kill it off in 2.5"
