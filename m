Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbQLND6Z>; Wed, 13 Dec 2000 22:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbQLND6O>; Wed, 13 Dec 2000 22:58:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3969 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130304AbQLND6E>;
	Wed, 13 Dec 2000 22:58:04 -0500
Date: Wed, 13 Dec 2000 19:11:41 -0800
Message-Id: <200012140311.TAA02688@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: pivo@pobox.sk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20001214041109.A997@ivan.doma> (message from Ivan Vadovic on
	Thu, 14 Dec 2000 04:11:09 +0100)
Subject: Re: IP ID == 0 ?!
In-Reply-To: <20001214041109.A997@ivan.doma>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 14 Dec 2000 04:11:09 +0100
   From: Ivan Vadovic <pivo@pobox.sk>

   I've been having weird problems with 2.4 kernels ip networking. I
   can't connect to several sites ( hotmail.com,intel.com... ). After
   some investigation with tcpdump I figured that the IDentification
   field of every outgoing ip packet is set to zero and then it
   doesn't get through some few firewalls. I'm surprised I haven't
   found anything about it in the list archives, so I'm trying to get
   help here. Did I forget to configure something?

No, the sites have firewalls erroneously blocking ECN, try:

echo "0" >/proc/sys/net/ipv4/tcp_ecn

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
