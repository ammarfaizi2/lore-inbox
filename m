Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287571AbSAQBKQ>; Wed, 16 Jan 2002 20:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSAQBKH>; Wed, 16 Jan 2002 20:10:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49282 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287571AbSAQBJy>;
	Wed, 16 Jan 2002 20:09:54 -0500
Date: Wed, 16 Jan 2002 17:08:52 -0800 (PST)
Message-Id: <20020116.170852.91311984.davem@redhat.com>
To: wilson@whack.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hires timestamps for netif_rx()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.40.0201161658260.28457-100000@apogee.whack.org>
In-Reply-To: <20020116.161759.68040363.davem@redhat.com>
	<Pine.GSO.4.40.0201161658260.28457-100000@apogee.whack.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Wilson Yeung <wilson@whack.org>
   Date: Wed, 16 Jan 2002 17:03:58 -0800 (PST)
   
   The discreprency is that get_fast_time() returns the current value of
   xtime, while do_gettimeofday() may actually calculate the time and
   consider both xtime and the jiffies.
   
Look at the x86 implementation of do_fast_time, it equals
do_gettimeofday() when TSC is present which is the only time
that do_gettimeofday is going to be more accurate than xtime.

Franks a lot,
David S. Miller
davem@redhat.com
