Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUG2AU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUG2AU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUG2ASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:18:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35993 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266409AbUG2AQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:16:26 -0400
Date: Wed, 28 Jul 2004 17:14:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: peter@chubb.wattle.id.au, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
Message-Id: <20040728171414.5de8da96.davem@redhat.com>
In-Reply-To: <20040729000837.GA24956@taniwha.stupidest.org>
References: <233602095@toto.iv>
	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>
	<20040728154523.20713ef1.davem@redhat.com>
	<20040729000837.GA24956@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 17:08:37 -0700
Chris Wedgwood <cw@f00f.org> wrote:

> Just How bad is it for you?  I just tested stat on my crapbox and for
> a short path 1M stats takes 0.5s and for a longer path (30 bytes or
> so) 2.8s.

Run "time find . -type f" on the kernel tree, both before and
after removing the third unnecessary copy.  Many machines sit all
day and stat files.
