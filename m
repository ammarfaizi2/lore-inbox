Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUIEGGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUIEGGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 02:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUIEGGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 02:06:52 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:27308
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266236AbUIEGG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 02:06:27 -0400
Date: Sat, 4 Sep 2004 23:04:36 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/3] teach kswapd about watermarks
Message-Id: <20040904230436.1604215a.davem@davemloft.net>
In-Reply-To: <413AA879.9020105@yahoo.com.au>
References: <413AA7B2.4000907@yahoo.com.au>
	<413AA7F8.3050706@yahoo.com.au>
	<413AA841.1040003@yahoo.com.au>
	<413AA879.9020105@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you're only doing atomic_set() and atomic_read() on kswapd_max_order,
you're not doing anything atomic on the datum so no need to make it
an atomic_t.
