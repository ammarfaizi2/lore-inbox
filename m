Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133098AbRD3FL2>; Mon, 30 Apr 2001 01:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133101AbRD3FLS>; Mon, 30 Apr 2001 01:11:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60820 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S133098AbRD3FLA>;
	Mon, 30 Apr 2001 01:11:00 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15084.62398.56283.772414@pizda.ninka.net>
Date: Sun, 29 Apr 2001 22:10:22 -0700 (PDT)
To: Ralf Nyren <ralf@nyren.net>
Cc: <linux-kernel@vger.kernel.org>, kuznet@ms2.inr.ac.ru
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
In-Reply-To: <Pine.LNX.4.31.0104291552190.523-100000@HADDOCK.100Mbit.nyren.net>
In-Reply-To: <Pine.LNX.4.31.0104291552190.523-100000@HADDOCK.100Mbit.nyren.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ralf Nyren writes:
 > The problem appears when this value is set to 40481 or higher. For ex:
 > $ tcpblast -d0 -s 40481 another_host 9000
 ...
 > KERNEL: assertion (!skb_queue_empty(&sk->write_queue)) failed at tcp_timer.c(327):
 > tcp_retransmit_timer
 > Unable to handle kernel NULL pointer dereference...

I'm having a devil of a time finding the tcpblast sources on the
net, can you point me to where I can get them?  The one reference
I saw to get the original sources was:

ftp://ftp.xlink.net/pub/network/tcpblast.shar.gz

But even that directory no longer exists.

The kernel error you see is a gross fatal error, the TCP retransmit
timer has fired yet there are no packets on the transmit queue :-)

My current theory is that tcpblast does something erratic when the
error occurs.

Later,
David S. Miller
davem@redhat.com
