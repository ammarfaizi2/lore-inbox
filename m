Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289951AbSAKNqx>; Fri, 11 Jan 2002 08:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289953AbSAKNqe>; Fri, 11 Jan 2002 08:46:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29314 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289951AbSAKNqX>;
	Fri, 11 Jan 2002 08:46:23 -0500
Date: Fri, 11 Jan 2002 05:45:25 -0800 (PST)
Message-Id: <20020111.054525.107941129.davem@redhat.com>
To: go@turbolinux.co.jp
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        sd@turbolinux.co.jp
Subject: Re: [PATCH] removed socket buffer in unix domain socket
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C3EE76C.1030808@turbolinux.co.jp>
In-Reply-To: <E16NaD0-0001Hs-00@the-village.bc.nu>
	<3C3EE76C.1030808@turbolinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Go Taniguchi <go@turbolinux.co.jp>
   Date: Fri, 11 Jan 2002 22:23:56 +0900

   What size of actually used hash table --unix_socket_table--?
   If it is 256, probably forall_unix_sockets is dangerous.
   
   forall_unix_sockets use 257 table size.
   And If I apply this fix, test program can work.
   
Slot 256 is a special slot fo unbound sockets.  The table is
sized to UNIX_HASH_SIZE + 1, so it is ok and your patch is
not right.

Please see the other email from Alexey Kuznetsov which includes
a real fix for your bug.
