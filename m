Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287768AbSAKI7x>; Fri, 11 Jan 2002 03:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289896AbSAKI7n>; Fri, 11 Jan 2002 03:59:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14720 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287768AbSAKI73>;
	Fri, 11 Jan 2002 03:59:29 -0500
Date: Fri, 11 Jan 2002 00:58:30 -0800 (PST)
Message-Id: <20020111.005830.104033901.davem@redhat.com>
To: alad@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locked page handling in shrink_cache() : revised
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <65256B3E.0030C343.00@sandesh.hss.hns.com>
In-Reply-To: <65256B3E.0030C343.00@sandesh.hss.hns.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: alad@hss.hns.com
   Date: Fri, 11 Jan 2002 14:17:25 +0530
   
   Sorry...
   I have corrected tha patch.
   
   +                   list_del(&page.lru);
   +                   list_add(&page.lru,inactive_list.prev);

Did you try to compile this? :-) 'page' is a pointer, so
to dereference it's lru member you must use page->lru not
page.lru
