Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRG0SGu>; Fri, 27 Jul 2001 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbRG0SGl>; Fri, 27 Jul 2001 14:06:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56074 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268919AbRG0SGX>; Fri, 27 Jul 2001 14:06:23 -0400
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
To: samudrala@us.ibm.com (Sridhar Samudrala)
Date: Fri, 27 Jul 2001 19:07:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        samudrala@us.ibm.com (Sridhar Samudrala), linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, lartc@mailman.ds9a.nl,
        diffserv-general@lists.sourceforge.net, kuznet@ms2.inr.ac.ru,
        rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.21.0107271036390.14246-100000@w-sridhar2.des.sequent.com> from "Sridhar Samudrala" at Jul 27, 2001 11:01:00 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QC1U-0006C6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> There are couple of reasons why prioritization in kernel works better than at 
> user level. 
> * The kernel mechanisms are more efficient and scalable than the user space
>   mechanism. Non compliant connection requests are discarded earlier reducing the
>   queuing time of the compliant requests, in particular less CPU is consumed and
>   the context switch to userspace is avoided. 

Im not sure this is that true. I just added a user space implementation to
thttpd to favour one network range and close under load on others to keep
capacity there. Its a ten minute hack, and Im still seeing the same 1400
hits per second or so I was before.

Alan
