Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSICGy6>; Tue, 3 Sep 2002 02:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318717AbSICGy5>; Tue, 3 Sep 2002 02:54:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62161 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318561AbSICGy4>;
	Tue, 3 Sep 2002 02:54:56 -0400
Date: Mon, 02 Sep 2002 23:52:44 -0700 (PDT)
Message-Id: <20020902.235244.64832172.davem@redhat.com>
To: jros@ece.uci.edu
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       kuznet@ms2.inr.ac.ru, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <JCEFIMMPGNNGFPMJJKINGEMHCDAA.jros@ece.uci.edu>
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
	<JCEFIMMPGNNGFPMJJKINGEMHCDAA.jros@ece.uci.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Jordi Ros" <jros@ece.uci.edu>
   Date: Mon, 2 Sep 2002 21:58:32 -0700

   i assume the mtu is ethernet 1500 Bytes, right? and that mss should be
   something much bigger than mtu, which gives the performance improvement
   shown in the numbers.
   
The performance improvement comes from the fact that the card
is given huge 64K packets, then the card (using the given ip/tcp
headers as a template) spits out 1500 byte mtu sized packets.

Less data DMA'd to the device per normal-mtu packet and less
per-packet data structure work by the cpu is where the improvement
comes from.
