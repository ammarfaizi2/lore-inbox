Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290643AbSA3WAa>; Wed, 30 Jan 2002 17:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290644AbSA3WAP>; Wed, 30 Jan 2002 17:00:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60040 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290641AbSA3V7i>;
	Wed, 30 Jan 2002 16:59:38 -0500
Date: Wed, 30 Jan 2002 13:58:04 -0800 (PST)
Message-Id: <20020130.135804.08322556.davem@redhat.com>
To: root@chaos.analogic.com
Cc: landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: TCP/IP Speed
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1020130163406.21490A-100000@chaos.analogic.com>
In-Reply-To: <20020130212344.ZLSQ25963.femail43.sdc1.sfba.home.com@there>
	<Pine.LNX.3.95.1020130163406.21490A-100000@chaos.analogic.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Wed, 30 Jan 2002 16:54:46 -0500 (EST)
   
   No. I set all sockets, even the original listen() socket to
   TCP_NODELAY.

How about setting it on the resulting socket, not just the
listen one?  Ie. at both ends always set TCP_NODELAY to 1
on each new socket created.

Nagle (Ie. TCP_NODELAY) is the only thing which could explain
the behavior you are complaining about.
