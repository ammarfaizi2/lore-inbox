Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTFDF7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTFDF7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:59:20 -0400
Received: from palrel10.hp.com ([156.153.255.245]:24272 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262930AbTFDF7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:59:19 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.36319.412668.87363@napali.hpl.hp.com>
Date: Tue, 3 Jun 2003 23:12:47 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, niv@us.ibm.com,
       kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
In-Reply-To: <20030603.225245.55753285.davem@redhat.com>
References: <16093.30507.661714.676184@napali.hpl.hp.com>
	<3EDD7832.7010804@us.ibm.com>
	<16093.34022.445246.52398@napali.hpl.hp.com>
	<20030603.225245.55753285.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 03 Jun 2003 22:52:45 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  David>    From: David Mosberger <davidm@napali.hpl.hp.com> Date:
  David> Tue, 3 Jun 2003 22:34:30 -0700

  David>    You can't go higher than 1000 conn/sec per client (IP
  David> address) because otherwise you run out of port space (due to
  David> TIME_WAIT).

  DaveM> echo "1" >/proc/sys/net/ipv4/tcp_tw_recycle

  DaveM> It should eliminate this limit.  Unfortunately we can't
  DaveM> enable this by default because of NAT :(

Ah, yes, provided PAWS is enabled, this would give you a time_wait
timeout of 3.5*RTO.  Nice.

	--david
