Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRACQsp>; Wed, 3 Jan 2001 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132545AbRACQsf>; Wed, 3 Jan 2001 11:48:35 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:14606 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S132109AbRACQsX>;
	Wed, 3 Jan 2001 11:48:23 -0500
Date: Wed, 3 Jan 2001 21:47:33 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: sock_alloc_send_skb
Message-ID: <Pine.SOL.3.96.1010103214259.7013A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	why in sock_alloc_send_skb(sk,
		length+hh_len+15,0,flags&MSG_DONTWAIT, &err) 

15 is added to the length of the the data of the socket. Here
length=data_len+ip_hdr+udp_hdr all we need is hrd_hdr ie hh_len which is
being added here, why that 15 is needed?

Sourav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
