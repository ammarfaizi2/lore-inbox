Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUF2Sv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUF2Sv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUF2Sv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:51:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3792 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265930AbUF2SvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:51:00 -0400
Date: Tue, 29 Jun 2004 11:50:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: debi.janos@freemail.hu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629115033.46383033.davem@redhat.com>
In-Reply-To: <20040629112256.58828632@dell_ss3.pdx.osdl.net>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	<20040629112256.58828632@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 11:22:56 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> To turn of receive buffer auto-tuning:
> 	sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
> 	sysctl -w net.ipv4.tcp_default_win_scale=0

It may be just the window scaling that's causing the grief
so people can try just setting tcp_default_win_scale to zero
and leaving tcp_moderate_rcvbuf enabled.

That would be an important data-point.
