Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbSJTWVF>; Sun, 20 Oct 2002 18:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264652AbSJTWVF>; Sun, 20 Oct 2002 18:21:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41949 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264651AbSJTWVE>;
	Sun, 20 Oct 2002 18:21:04 -0400
Date: Sun, 20 Oct 2002 15:19:10 -0700 (PDT)
Message-Id: <20021020.151910.81693390.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org, coreteam@netfilter.org
Subject: Re: [RFC] bridge-nf -- map IPv4 hooks onto bridge hooks, vs 2.5.44
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210210020.37097.bart.de.schuymer@pandora.be>
References: <200209120836.52062.bart.de.schuymer@pandora.be>
	<200210142005.06292.bart.de.schuymer@pandora.be>
	<200210210020.37097.bart.de.schuymer@pandora.be>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Bart De Schuymer <bart.de.schuymer@pandora.be>
   Date: Mon, 21 Oct 2002 00:20:37 +0200

   This is a follow-up from the previous RFC for the bridge-nf patch.
   The new patch adds one member to the skbuff, a pointer to a struct 
   nf_bridge_info. There is still a need to change ip_output.c, but the change 
   is the analogue as is done for the skbuff->nfct pointer field. So, for me 
   this is a clean solution. The copy of the Ethernet header is no longer done 
   in ip_fragment().

This definitely looks a lot better.

I still want the netfilter team to 'ACK' the core/ipv4 netfilter
changes before I apply this. :-)
