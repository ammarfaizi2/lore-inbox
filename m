Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTFOOe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTFOOe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:34:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28870 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262284AbTFOOe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:34:26 -0400
Date: Sun, 15 Jun 2003 07:44:05 -0700 (PDT)
Message-Id: <20030615.074405.39168044.davem@redhat.com>
To: hdierks@us.ibm.com
Cc: ltd@cisco.com, anton@samba.org, haveblue@us.ibm.com,
       scott.feldman@intel.com, dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       milliner@us.ibm.com, ricardoz@us.ibm.com, twichell@us.ibm.com,
       netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF7D02DC37.06BCABE8-ON85256D46.004E9127@pok.ibm.com>
References: <OF7D02DC37.06BCABE8-ON85256D46.004E9127@pok.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Herman Dierks" <hdierks@us.ibm.com>
   Date: Sun, 15 Jun 2003 09:40:41 -0500
   
   With TSO being the default,   the small packet case
   becomes less important anyway.

This is a very narrow and unrealistic view of the situation.

Every third packet your system will process for any connection will be
an ACK, a small packet.  Most database and web and database
transactions happen using small packets for the transaction request.

Look, if you're gonna sit here and just rant justifying this bogus
behavior of your hardware, it is likely to go in one ear and out the
other.  Nobody wants to hear excuses. :)

The fact is, this system handles sub-cacheline reads inefficiently
even if a sequences of transactions are consequetive and to the same
cache line and no coherency transactions occur to that cache line.

That is dumb, and there is no arguing around this.  You would be
sensible to realize this, and accept it whilst others try to help you
find a solution for your problem.
