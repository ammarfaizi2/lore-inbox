Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTFDFnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTFDFnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:43:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50901 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262903AbTFDFnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:43:14 -0400
Date: Tue, 03 Jun 2003 22:52:45 -0700 (PDT)
Message-Id: <20030603.225245.55753285.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: niv@us.ibm.com, kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16093.34022.445246.52398@napali.hpl.hp.com>
References: <16093.30507.661714.676184@napali.hpl.hp.com>
	<3EDD7832.7010804@us.ibm.com>
	<16093.34022.445246.52398@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 3 Jun 2003 22:34:30 -0700
   
   You can't go higher than 1000 conn/sec per client (IP address)
   because otherwise you run out of port space (due to TIME_WAIT).

echo "1" >/proc/sys/net/ipv4/tcp_tw_recycle

It should eliminate this limit.  Unfortunately we can't enable
this by default because of NAT :(
