Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUBXSZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUBXSYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:24:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262394AbUBXSWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:22:16 -0500
Date: Tue, 24 Feb 2004 10:22:08 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
Message-Id: <20040224102208.4fd285e3.davem@redhat.com>
In-Reply-To: <Pine.OSF.4.21.0402240922280.430603-100000@mhc.mtholyoke.edu>
References: <Pine.OSF.4.21.0402232326560.192063-100000@mhc.mtholyoke.edu>
	<Pine.OSF.4.21.0402240922280.430603-100000@mhc.mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So Ron, as performance gets worse and worse, take a look at what the firewall
rules in the kernel look like.   I bet you're accumulating netfilter ipchains
rules over time and this makes packet processing go slower and slower, and it's
due to some bug in whatever is dynamically adding firewall rules to your system.

I'm guessing all of this because that is exactly what was causing problems for
someone who reported something basically identical to what you're reporting now
the other week.
