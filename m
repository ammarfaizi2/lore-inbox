Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275698AbRIZXkG>; Wed, 26 Sep 2001 19:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275699AbRIZXj4>; Wed, 26 Sep 2001 19:39:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55712 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S275698AbRIZXjn>;
	Wed, 26 Sep 2001 19:39:43 -0400
Date: Wed, 26 Sep 2001 16:39:46 -0700 (PDT)
Message-Id: <20010926.163946.11595354.davem@redhat.com>
To: Ulrich.Weigand@de.ibm.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        utz.bacher@de.ibm.com
Subject: Re: Bug in tcp_v4_hnd_req?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF9A5AA6CF.110D18E7-ONC1256AD3.0080234F@de.ibm.com>
In-Reply-To: <OF9A5AA6CF.110D18E7-ONC1256AD3.0080234F@de.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
   Date: Thu, 27 Sep 2001 01:27:33 +0200

   the following code in tcp_v4_hnd_req looks broken:
   
 ...
             tcp_tw_put((struct tcp_tw_bucket*)sk);
   
   Shouldn't it put *nsk* instead of sk?  This appears to be the cause of
   weird crashes under heavy network load we've been experiencing ...

Indeed, you are correct and I've also made the fix for ipv6 in my tree
as it had the same exact problem.

Franks a lot,
David S. Miller
davem@redhat.com
