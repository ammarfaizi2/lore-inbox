Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269598AbUJFWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269598AbUJFWpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269582AbUJFWlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:41:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:42651
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269531AbUJFWdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:33:36 -0400
Date: Wed, 6 Oct 2004 15:32:46 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: alan@lxorguk.ukuu.org.uk, martijn@entmoot.nl, aebr@win.tue.nl,
       joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006153246.4f2f45e4.davem@davemloft.net>
In-Reply-To: <20041006221512.GE4523@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	<1097080873.29204.57.camel@localhost.localdomain>
	<Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl>
	<20041006193053.GC4523@pclin040.win.tue.nl>
	<1097090625.29707.9.camel@localhost.localdomain>
	<00f201c4abf1$0444c3e0$161b14ac@boromir>
	<1097094326.29871.9.camel@localhost.localdomain>
	<20041006221512.GE4523@pclin040.win.tue.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 00:15:12 +0200
Andries Brouwer <aebr@win.tue.nl> wrote:

> I would hope that checksum failure is not the fast path,
> so at zeroth sight, not having looked at the code, it seems
> that we could do rather elaborate things on checksum failure
> if we wanted to.

The code in question is in net/ipv4/udp.c:udp_recvmsg()
