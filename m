Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTA2HgT>; Wed, 29 Jan 2003 02:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTA2HgT>; Wed, 29 Jan 2003 02:36:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49564 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265077AbTA2HgS>;
	Wed, 29 Jan 2003 02:36:18 -0500
Date: Tue, 28 Jan 2003 23:32:57 -0800 (PST)
Message-Id: <20030128.233257.11926946.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: benoit-lists@fb12.de, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200301290314.GAA31081@sex.inr.ac.ru>
References: <20030128.160806.13210372.davem@redhat.com>
	<200301290314.GAA31081@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Wed, 29 Jan 2003 06:14:55 +0300 (MSK)
   
   skb->csum is not used inside TCP when skb->ip_summed==CHECKSUM_HW:
  ...   
   So, it is safe to make skb->ip_summed := CHECKSUM_HW any moment when
   we are lazy to recalculate checksum.

I see, clever trick as I had suspected.

Thanks for the explanation.
