Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbUJ1F3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbUJ1F3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUJ1F3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:29:37 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:15495
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262777AbUJ1F3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:29:32 -0400
Date: Wed, 27 Oct 2004 22:21:28 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Meda, Prasanna" <pmeda@akamai.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
Subject: Re: rcv_wnd = init_cwnd*mss
Message-Id: <20041027222128.365536e7.davem@davemloft.net>
In-Reply-To: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B07@usca1ex-priv1.sanmateo.corp.akamai.com>
References: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B07@usca1ex-priv1.sanmateo.corp.akamai.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 22:14:33 -0700
"Meda, Prasanna" <pmeda@akamai.com> wrote:

> 
> What is the reason for checking mss with 1<<rcv_wscale?
> include/net/tcp.h:

Because the advertised window field is 16-bits.  It is
interpreted as "value << rcv_wscale"
