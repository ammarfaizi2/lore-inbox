Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUBHXLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBHXLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:11:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264288AbUBHXLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:11:35 -0500
Date: Sun, 8 Feb 2004 15:11:21 -0800
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ?
Message-Id: <20040208151121.1e63a8f2.davem@redhat.com>
In-Reply-To: <20040208230331.79FEB2C003@lists.samba.org>
References: <1076238833.12587.229.camel@imladris.demon.co.uk>
	<20040208230331.79FEB2C003@lists.samba.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Feb 2004 10:00:47 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Um, we do?  I thought it was compulsory in the kernel, otherwise
> networking breaks on packets w/ wierd hardware headers.

That's right, for the old old ARMs they've always been broken
with certain types of encapsulations due to this.  Even just feed
them certain kinds of odd TCP/IP option sequences and watch the
packet handling work on corrupted header data on such older ARMs.
