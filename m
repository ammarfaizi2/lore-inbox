Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTFDGGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 02:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTFDGGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 02:06:04 -0400
Received: from palrel10.hp.com ([156.153.255.245]:28371 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262942AbTFDGGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 02:06:03 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.36723.418623.698303@napali.hpl.hp.com>
Date: Tue, 3 Jun 2003 23:19:31 -0700
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
In-Reply-To: <3EDD8BD2.9040008@us.ibm.com>
References: <200306040043.EAA24505@dub.inr.ac.ru>
	<3EDD52F5.8090706@us.ibm.com>
	<20030603.202320.59680883.davem@redhat.com>
	<16093.30507.661714.676184@napali.hpl.hp.com>
	<3EDD7832.7010804@us.ibm.com>
	<16093.34022.445246.52398@napali.hpl.hp.com>
	<3EDD8BD2.9040008@us.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 03 Jun 2003 23:04:02 -0700, Nivedita Singhvi <niv@us.ibm.com> said:

  Nivedita> Those should be TCPAbortOnTimeout counts, rather than
  Nivedita> TCPAbortFailed errors, I would expect? Why AbortFailed?
  Nivedita> Coming from IP via tcp_transmit_skb()?

Yes, the "connection hangs/disappearances" where triggered by
TCPAbortOnTimeout; the TCPAbortFailed errors were indicating that
tcp_transmit_skb() had failed, i.e., the tx queue was overrun (that's
were the losses came from).

	--david
