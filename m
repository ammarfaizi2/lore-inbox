Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSHYWuk>; Sun, 25 Aug 2002 18:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSHYWuk>; Sun, 25 Aug 2002 18:50:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1156 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317641AbSHYWuj>;
	Sun, 25 Aug 2002 18:50:39 -0400
Date: Sun, 25 Aug 2002 15:49:24 -0700 (PDT)
Message-Id: <20020825.154924.104033788.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: packet re-ordering on SMP machines.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030286473.16651.7.camel@irongate.swansea.linux.org.uk>
References: <3D6884BC.5090004@candelatech.com>
	<1030286473.16651.7.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 25 Aug 2002 15:41:13 +0100

   > 3)  If answer to 2 is no, would you all be interested in a patch that
   >      did allow strict ordering (if indeed I can figure out how to write one)?
   
   You should never need it. Ethernet, hubs, switches, routers, internet
   backbones etc will all cause packet re-ordering. You should also expect
   the percentage of re-ordered frames on the net to rise and rise. 
   
But to be honest, NAPI was meant to dramatically reduce the "SMP
specific" causes of packet reordering.  When a driver does use NAPI,
the reordering due to SMP goes way down.
