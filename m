Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRKNLsm>; Wed, 14 Nov 2001 06:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280484AbRKNLsW>; Wed, 14 Nov 2001 06:48:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19587 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280480AbRKNLsS>;
	Wed, 14 Nov 2001 06:48:18 -0500
Date: Wed, 14 Nov 2001 03:48:15 -0800 (PST)
Message-Id: <20011114.034815.35015101.davem@redhat.com>
To: tip@internetwork-ag.de
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] ppp_generic causes skput:under: w/ pppoatm andvc-encaps
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BF251C6.23CD1243@internetwork-ag.de>
In-Reply-To: <3BF190F0.3FB26BD0@internetwork-ag.de>
	<20011113.210221.55509229.davem@redhat.com>
	<3BF251C6.23CD1243@internetwork-ag.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Till Immanuel Patzschke <tip@internetwork-ag.de>
   Date: Wed, 14 Nov 2001 12:13:10 +0100
   
   that is - of course - a more pppoatm specific fix BUT my concern
   ist that PPP requires (!) to have at least 2 bytes headroom [when
   using PPP_FILTER] (which is NOT noted), and isn't it good practice
   to check for room before claiming it?

Ignore my comments, I thought this was happening on output.
Yes, it seems ppp_generic should be verifying the headroom.

Franks a lot,
David S. Miller
davem@redhat.com
