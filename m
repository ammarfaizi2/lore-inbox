Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319513AbSIMEda>; Fri, 13 Sep 2002 00:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319515AbSIMEda>; Fri, 13 Sep 2002 00:33:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24517 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319513AbSIMEd3>;
	Fri, 13 Sep 2002 00:33:29 -0400
Date: Thu, 12 Sep 2002 21:29:59 -0700 (PDT)
Message-Id: <20020912.212959.114182683.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: buytenh@math.leidenuniv.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ebtables - Ethernet bridge tables, for 2.5.34
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209130520.41862.bart.de.schuymer@pandora.be>
References: <200209120836.52062.bart.de.schuymer@pandora.be>
	<20020912.160411.66846285.davem@redhat.com>
	<200209130520.41862.bart.de.schuymer@pandora.be>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Fri, 13 Sep 2002 05:20:41 +0200
   
   Well, a bridge can also just _bridge_ ARP packets between two sides of the 
   bridge. The ARP module can filter out those packets. These packets will not 
   pass through the ARP code of the Linux kernel. Ofcourse, the ebtables ARP 
   module can be easily adjusted for arptables

No, I think I understand the difference and why you're problem
space does not intersect what arptables handles.

It may not be nice that we can't immediately just reuse ipv4/netfilter
handlers for bridging, but I'm not going to require that you make that
work before I'll accept your patch.

Once you work things out with Lennert and he approves the changes,
I'll apply your patch.
