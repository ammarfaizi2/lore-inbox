Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSJaCs3>; Wed, 30 Oct 2002 21:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJaCs3>; Wed, 30 Oct 2002 21:48:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265114AbSJaCs2>;
	Wed, 30 Oct 2002 21:48:28 -0500
Date: Wed, 30 Oct 2002 18:44:43 -0800 (PST)
Message-Id: <20021030.184443.87162307.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: boissiere@adiglobal.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5] October 30, 2002
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021031.114832.59687399.yoshfuji@linux-ipv6.org>
References: <20021031.005535.67557509.yoshfuji@linux-ipv6.org>
	<20021030.143615.10738219.davem@redhat.com>
	<20021031.114832.59687399.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Thu, 31 Oct 2002 11:48:32 +0900 (JST)

   In article <20021030.143615.10738219.davem@redhat.com> (at Wed, 30 Oct 2002 14:36:15 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:
   
   > We told you several times how this USAGI patch is not currently in an
   > acceptable form and needs to be reimplemented via the routing code.
   
   Yes, but I think
     - integrate our code to your tree
   then
     - reimplement (re-design)
   is better way to go forward.
   
Absolutely not, we do not put improperly architected code into the
tree first then clean it up later.

Especially because this source address selection code interferes with
many IPSEC issues.  Source address selection belongs at routing
tables, and there is no arguing about this.  If you put it somewhere
else it gets in the way and causes many problems.

Please implement source address selection properly, then resubmit.
Thank you.
   
   I need to check the result of current code and 
   to look at diff by byte-to-byte before preparing
   patches for current tree.
   
Ok.
   
