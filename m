Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVAaC4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVAaC4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 21:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVAaC4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 21:56:14 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14300
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261901AbVAaC4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 21:56:12 -0500
Date: Sun, 30 Jan 2005 18:48:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: rmk+lkml@arm.linux.org.uk, Robert.Olsson@data.slu.se, akpm@osdl.org,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-Id: <20050130184836.17b0487b.davem@davemloft.net>
In-Reply-To: <41FD2043.3070303@trash.net>
References: <20050124114853.A16971@flint.arm.linux.org.uk>
	<20050125193207.B30094@flint.arm.linux.org.uk>
	<20050127082809.A20510@flint.arm.linux.org.uk>
	<20050127004732.5d8e3f62.akpm@osdl.org>
	<16888.58622.376497.380197@robur.slu.se>
	<20050127164918.C3036@flint.arm.linux.org.uk>
	<20050127123326.2eafab35.davem@davemloft.net>
	<20050128001701.D22695@flint.arm.linux.org.uk>
	<20050127163444.1bfb673b.davem@davemloft.net>
	<20050128085858.B9486@flint.arm.linux.org.uk>
	<20050130132343.A25000@flint.arm.linux.org.uk>
	<41FD17FE.6050007@trash.net>
	<41FD18C5.6090108@trash.net>
	<41FD2043.3070303@trash.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 18:58:27 +0100
Patrick McHardy <kaber@trash.net> wrote:

> Ok, final decision: you are right :) conntrack also defragments locally
> generated packets before they hit ip_fragment. In this case the fragments
> have skb->dst set.

It's amazing how many bugs exist due to the local defragmentation and
refragmentation done by netfilter. :-)

Good catch Patrick, I'll apply this and push upstream.
