Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280149AbRKNFCk>; Wed, 14 Nov 2001 00:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280146AbRKNFCa>; Wed, 14 Nov 2001 00:02:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16256 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280136AbRKNFC0>;
	Wed, 14 Nov 2001 00:02:26 -0500
Date: Tue, 13 Nov 2001 21:02:21 -0800 (PST)
Message-Id: <20011113.210221.55509229.davem@redhat.com>
To: tip@internetwork-ag.de
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] ppp_generic causes skput:under: w/ pppoatm and
 vc-encaps
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de>
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Till Immanuel Patzschke <tip@internetwork-ag.de>
   Date: Tue, 13 Nov 2001 22:30:24 +0100

   I've attached a patch, checking for headroom first, and - if necessary -
   reallocating a larger buffer for the skb_push.
   
   Please check and apply - or find a better fix!
   
Here is my "better fix". In pppoatm, we should be increasing the
device header length appropriately.  ie. dev->hard_header_len needs to
be increased in the pppoatm driver when vc-encaps is used.

Franks a lot,
David S. Miller
davem@redhat.com
