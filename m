Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265309AbUETWvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbUETWvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbUETWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:51:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22673 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265292AbUETWu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:50:57 -0400
Date: Thu, 20 May 2004 15:50:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, pekkas@netcore.fi
Subject: Re: [PATCH] IPv6 can't be built as module additionally
Message-Id: <20040520155042.223b05e3.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz>
References: <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004 00:16:06 +0200 (CEST)
Jirka Kosina <jikos@jikos.cz> wrote:

> This is because ipv6-specific functions in drivers/char/random.c 
> are inside #ifdefs, and as random.c is almost always built directly into 
> kernel, recompilation of whole kernel can't be avoided.

This is the smallest problem, several main kernel data structures
change size based upon whether ipv6 has been enabled in any way
or not.

So even with your patch, compiling ipv6 outside of the kernel will
still not work even though it might build.

This has been discussed to death in the past I do believe :-)
