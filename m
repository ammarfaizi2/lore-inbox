Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261484AbSIZUyG>; Thu, 26 Sep 2002 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSIZUyG>; Thu, 26 Sep 2002 16:54:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22154 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261484AbSIZUyF>;
	Thu, 26 Sep 2002 16:54:05 -0400
Date: Thu, 26 Sep 2002 13:52:59 -0700 (PDT)
Message-Id: <20020926.135259.62665945.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: rusty@rustcorp.com.au, nf@hipac.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
 for Netfilter
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0209270122570.12511-100000@blackbird.intercode.com.au>
References: <20020925.224001.99456805.davem@redhat.com>
	<Mutt.LNX.4.44.0209270122570.12511-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Fri, 27 Sep 2002 01:27:41 +1000 (EST)
   
   So, this could be used for generic network layer encapsulation, and be 
   used for GRE tunnels, SIT etc. without the kinds of kludges currently in 
   use?  Sounds nice.

Such IPIP tunnels have very real problems though, since only 64-bits
of packet quoting are required in ICMP errors, it is often impossible
to deal with PMTU requests properly, see "#ifndef
I_WISH_WORLD_WERE_PERFECT" in net/ipv4/ip_gre.c
