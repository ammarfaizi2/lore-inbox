Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUGFUbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUGFUbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGFUbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:31:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264414AbUGFUbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:31:16 -0400
Date: Tue, 6 Jul 2004 13:28:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jamie@shareable.org, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040706132822.70c8174a.davem@redhat.com>
In-Reply-To: <20040706130549.31daa8e0@dell_ss3.pdx.osdl.net>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	<20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<20040706194034.GA11021@mail.shareable.org>
	<20040706130549.31daa8e0@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004 13:05:49 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> On Tue, 6 Jul 2004 20:40:34 +0100
> Jamie Lokier <jamie@shareable.org> wrote:
> 
> > Are you saying there are broken firewalls which strip TCP options in
> > one direction only?
> 
> It appears so.

Ok, this is a possibility.  And why it breaks is that if the ACK
for the SYN+ACK comes back, the SYN+ACK sender can only assume
that the window scale was accepted.

Stephen, do you have a trace showing exactly this?
