Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSBGMbr>; Thu, 7 Feb 2002 07:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSBGMbi>; Thu, 7 Feb 2002 07:31:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287578AbSBGMbZ>;
	Thu, 7 Feb 2002 07:31:25 -0500
Date: Thu, 07 Feb 2002 04:29:03 -0800 (PST)
Message-Id: <20020207.042903.71864726.davem@redhat.com>
To: riel@conectiva.com.br
Cc: alan@lxorguk.ukuu.org.uk, Ulrich.Weigand@de.ibm.com, zaitcev@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: The IBM order relaxation patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0202071015470.17850-100000@imladris.surriel.com>
In-Reply-To: <20020206.200100.85392985.davem@redhat.com>
	<Pine.LNX.4.33L.0202071015470.17850-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Thu, 7 Feb 2002 10:16:22 -0200 (BRST)

   The only problem is that it doesn't.  It won't try to free
   pages once you have enough free pages, which means you'll
   just end up in a livelock.

It always calls balance_classzone which always calls try_to_free_pages
which always will try to free SWAP_CLUSTER_MAX pages.

Oh, I see, is it that the old and RMAP VM won't do that? :-)

BTW, in checking this out it seems current->allocation_order is only
set and never checked anywhere.
