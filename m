Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSCLXRk>; Tue, 12 Mar 2002 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCLXRf>; Tue, 12 Mar 2002 18:17:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42368 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290289AbSCLXRE>;
	Tue, 12 Mar 2002 18:17:04 -0500
Date: Tue, 12 Mar 2002 15:14:43 -0800 (PST)
Message-Id: <20020312.151443.03370128.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropped packets on SUN GEM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015974664.2652.10.camel@monkey>
In-Reply-To: <1015974664.2652.10.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Beezly <beezly@beezly.org.uk>
   Date: 12 Mar 2002 23:11:04 +0000
   
   Is this normal? - Because it seems the amount of time to recover from a
   hang is inversely proportional to the amount of work it is doing, I am
   able to artificially improve the "uptime" of the card by permanantly
   running a ping -f <host> on the box!!

What I believe happens is that when the RX overflow condition occurs,
there will be some packets that will be corrupted as a result.

I find it really odd that you can reproduce this condition so readily.
Does it happen under normal usage or do you have to issue a ping flood
or some other packet intensive job to trigger the problem?  Also, are
you getting Pause enabled on the link consistently?
