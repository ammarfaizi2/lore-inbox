Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289845AbSAKDSX>; Thu, 10 Jan 2002 22:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSAKDSN>; Thu, 10 Jan 2002 22:18:13 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289845AbSAKDSJ>;
	Thu, 10 Jan 2002 22:18:09 -0500
Date: Thu, 10 Jan 2002 19:17:13 -0800 (PST)
Message-Id: <20020110.191713.48532251.davem@redhat.com>
To: "ChristianK."@t-online.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Briging doesn't compile without TCP/IP Networking
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16On3u-1zr9mqC@fwd05.sul.t-online.com>
In-Reply-To: <16On3u-1zr9mqC@fwd05.sul.t-online.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "ChristianK."@t-online.de (Christian Koenig)
   Date: Thu, 10 Jan 2002 22:50:45 +0100

   I accidently destroyed the Kernel of my self made bridge (old 486 / 4 PCI 
   nics).
   When i tried to compile an new one (2.4.17) I've got a compile error in
   include/net/tcp_ecn.h
   
   Is this patch suitable or could you tell me why unix sokets
   and others need tcp.h ? 

It is better to conditionalize or remove the include than to add
CONFIG_INET ifdefs to a TCP header :-)

I thought I had fixed this in current kernels...
