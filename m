Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281565AbRKPVym>; Fri, 16 Nov 2001 16:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281561AbRKPVyc>; Fri, 16 Nov 2001 16:54:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29058 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281565AbRKPVyW> convert rfc822-to-8bit;
	Fri, 16 Nov 2001 16:54:22 -0500
Date: Fri, 16 Nov 2001 13:54:09 -0800 (PST)
Message-Id: <20011116.135409.118971851.davem@redhat.com>
To: groudier@free.fr
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] block-highmem-all-18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011116193057.O1825-100000@gerard>
In-Reply-To: <20011116093927.E27010@suse.de>
	<20011116193057.O1825-100000@gerard>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Fri, 16 Nov 2001 19:59:02 +0100 (CET)
   
   On Fri, 16 Nov 2001, Jens Axboe wrote:
   
   > - Add sym2 can_dma_32 flag (me)
                ^^^^^^^^^^ Pooaaahhh!:) What's this utter oddity ?
   Only dma 32 ? :-)

It is workaround for buggy drivers, when set it means that single SG
list entry request will be handled correctly.  When clear it means
that single entry SG lists are to be avoided by the block layer.

Many devices would explode when given single entry scatterlist. :(

It's naming is questionable... that I agree with.  The name should be
more suggestive to what it really means.

Franks a lot,
David S. Miller
davem@redhat.com
