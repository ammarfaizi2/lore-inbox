Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279741AbRJ3BxK>; Mon, 29 Oct 2001 20:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279740AbRJ3BxA>; Mon, 29 Oct 2001 20:53:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18069 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279747AbRJ3Bwv>;
	Mon, 29 Oct 2001 20:52:51 -0500
Date: Mon, 29 Oct 2001 17:53:12 -0800 (PST)
Message-Id: <20011029.175312.26299226.davem@redhat.com>
To: maxk@qualcomm.com
Cc: pcg@goof.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5 && vtun not working
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.0.20011029174700.08e93090@mail1>
In-Reply-To: <20011030021740.A8708@schmorp.de>
	<20011030023933.A11774@schmorp.de>
	<5.1.0.14.0.20011029174700.08e93090@mail1>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Maksim Krasnyanskiy <maxk@qualcomm.com>
   Date: Mon, 29 Oct 2001 17:48:35 -0800

   >On Tue, Oct 30, 2001 at 02:17:40AM +0100, " Marc A. Lehmann " <pcg@goof.com> wrote:
   >> a _lot_ of searching revealed this code fragment:
   >
   >In my usual attempt to generate more traffic, I forgot to mention that I
   >found it in net/core/dev.c ;)
   >
   >(oh, and after reading the comments int hat file, I think that maybe tun.c
   >simply shouldn't call dev_alloc_name...)

   Hmm, let me check that. 
   I was under the assumption that it's dev.c bug :)

Basically, don't pass a string lack one "%d" into dev_alloc_name
because dev_alloc_name() runs sprintf on that string with an
integer argument.

Franks a lot,
David S. Miller
davem@redhat.com
