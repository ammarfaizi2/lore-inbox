Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967988AbWK3Xxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967988AbWK3Xxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967989AbWK3Xxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:53:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23995 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967988AbWK3Xxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:53:42 -0500
Date: Fri, 1 Dec 2006 00:00:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Matt Garman <matthew.garman@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
Message-ID: <20061201000030.1d8ba600@localhost.localdomain>
In-Reply-To: <456F34BE.5050303@cfl.rr.com>
References: <bdd6985b0611281405j3e731e3xc7973c0365428663@mail.gmail.com>
	<456DE85F.50806@cfl.rr.com>
	<bdd6985b0611300921u1a88f410vdaf9051c220719e1@mail.gmail.com>
	<456F34BE.5050303@cfl.rr.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, nagle was invented specifically for telnet.  Without nagle, every 

No it was general purpose. It fixes some extremely bad behaviour in TCP
with congestion well beyond the "telnet" behaviour.

> Things like mouse movements should not be sent over TCP at all.  UDP 
> makes a much better protocol for that kind of data since if a packet is 

UDP is rarely appropriate because it has no congestion control. There are
more appropriate protocols but they are rarely implemented so TCP
generally gets used.

> lost, there is no need to retransmit the same data; instead you just get 
> the next position update and don't care about where the mouse was during 
> the dropped packet.

