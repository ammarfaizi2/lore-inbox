Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbTFNF0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 01:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbTFNF0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 01:26:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28860 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265619AbTFNF0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 01:26:41 -0400
Date: Fri, 13 Jun 2003 22:36:34 -0700 (PDT)
Message-Id: <20030613.223634.74746570.davem@redhat.com>
To: niv@us.ibm.com
Cc: anton@samba.org, haveblue@us.ibm.com, hdierks@us.ibm.com,
       scott.feldman@intel.com, dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       milliner@us.ibm.com, ricardoz@us.ibm.com, twichell@us.ibm.com,
       netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEAAFA6.9080609@us.ibm.com>
References: <20030613223841.GB32097@krispykreme>
	<20030613.154634.74748085.davem@redhat.com>
	<3EEAAFA6.9080609@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Fri, 13 Jun 2003 22:16:22 -0700

   Yep, but it really doesn't have too many options (sic pun ;))..
   i.e. The max the options can add are 40 bytes, speaking
   strictly TCP, not IP. This really should fit into one extra
   cacheline for most architectures, at most, right?
   
It's what the bottom of the header is aligned to, but
we build the packet top to bottom not the other way around.
