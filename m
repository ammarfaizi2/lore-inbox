Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269650AbUJFXkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbUJFXkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUJFXjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:39:46 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:28316
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269617AbUJFXgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:36:10 -0400
Date: Wed, 6 Oct 2004 16:35:21 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006163521.2ae12e6d.davem@davemloft.net>
In-Reply-To: <20041006200608.GA29180@dspnet.fr.eu.org>
References: <20041006193053.GC4523@pclin040.win.tue.nl>
	<003301c4abdc$c043f350$b83147ab@amer.cisco.com>
	<20041006200608.GA29180@dspnet.fr.eu.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 22:06:08 +0200
Olivier Galibert <galibert@pobox.com> wrote:

> On Wed, Oct 06, 2004 at 12:43:27PM -0700, Hua Zhong wrote:
> > How hard is it to treat the next read to the fd as NON_BLOCKING, even if
> > it's not set?
> 
> Programs don't expect EAGAIN from blocking sockets.

That's right, which is why we block instead.
