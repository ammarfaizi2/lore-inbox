Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130640AbQKGDsq>; Mon, 6 Nov 2000 22:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130808AbQKGDsg>; Mon, 6 Nov 2000 22:48:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63104 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130640AbQKGDsZ>;
	Mon, 6 Nov 2000 22:48:25 -0500
Date: Mon, 6 Nov 2000 19:34:01 -0800
Message-Id: <200011070334.TAA01403@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ecki@lina.inka.de
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E13syeh-00018h-00@calista.inka.de> (message from Bernd Eckenfels
	on Tue, 07 Nov 2000 03:38:35 +0100)
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <E13syeh-00018h-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bernd Eckenfels <ecki@lina.inka.de>
   Date: 	Tue, 07 Nov 2000 03:38:35 +0100

   Because this will add a Fallback (non ECN) packet to every denied
   target. I think this is bad policy at least. It might violate the
   RFCs, too. Keep in mind, we cannot recognice a rejection due to
   ECN.

It does in fact violate RFCs because the fallback has to handle the
case where ECN rejection comes in the form of a (perfectly valid)
TCP reset.

Any workaround which ignores TCP resets is broken from the start and
is not to be implemented.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
