Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUHTSv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUHTSv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUHTSvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:51:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3549 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266003AbUHTSsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:48:22 -0400
Date: Fri, 20 Aug 2004 11:47:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: shemminger@osdl.org, alan@lxorguk.ukuu.org.uk, tytso@mit.edu,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
Message-Id: <20040820114710.39023b20.davem@redhat.com>
In-Reply-To: <20040820175952.GI5806@certainkey.com>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net>
	<20040820175952.GI5806@certainkey.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 13:59:52 -0400
Jean-Luc Cooke <jlcooke@certainkey.com> wrote:

> Is there a reason why get_random_bytes() is unsuitable?
> 
> Keeping the number of PRNGs in the kernel to a minimum should a goal we can
> all share.

Too expensive, this routine will get called potentially multiple times
per packet.
