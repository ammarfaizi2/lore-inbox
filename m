Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUHLTuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUHLTuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268682AbUHLTuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:50:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268680AbUHLTt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:49:56 -0400
Date: Thu, 12 Aug 2004 12:48:54 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, tytso@mit.edu, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040812124854.646f1936.davem@redhat.com>
In-Reply-To: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 10:48:35 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Here is a proposed alternative to use a longer period PRNG for net_random().
> The choice of TT800 was because it was freely available, had a long period,
> was fast and relatively small footprint. The existing net_random() was not
> really thread safe, but was immune to thread corruption. 

Any chance of a version that doesn't grab a global lock and
disable interrupts every call? :(
