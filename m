Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUJZXOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUJZXOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUJZXOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:14:37 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36072
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261536AbUJZXOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:14:30 -0400
Date: Tue, 26 Oct 2004 16:06:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: earny@net4u.de, linux-kernel@vger.kernel.org
Subject: Re: Neighbour table overflow.
Message-Id: <20041026160642.605f7fd7.davem@davemloft.net>
In-Reply-To: <200410270011.28818.dominik.karall@gmx.net>
References: <200410261939.33541.dominik.karall@gmx.net>
	<200410262352.20806.earny@net4u.de>
	<200410270011.28818.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 00:11:26 +0200
Dominik Karall <dominik.karall@gmx.net> wrote:

> On Tuesday 26 October 2004 23:52, Ernst Herzberg wrote:
> > On Tuesday 26 October 2004 19:39, Dominik Karall wrote:
> > > can anybody explain why i get thousands of "Neighbour table overflow."
> > > messages? i didn't get such ones with older kernels (~2.6.6).
> >
> > Do you set a default gateway?
> 
> yes, default gateway is set to our server.

Do you use a large subnet mask?  For example /16 or /8 or
something like that?

If so, you will need to bump up the neighbour table garbage
collection thresholds under /proc/sys/net/ipv4/neight/default/
Specifically gc_thresh1, gc_thresh2, and gc_thresh3

You probably have a huge number of machines on your subnet.
