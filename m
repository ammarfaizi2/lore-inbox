Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUHLAoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUHLAoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268455AbUHLAmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:42:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24540 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268486AbUHLAke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:40:34 -0400
Date: Wed, 11 Aug 2004 17:39:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: torvalds@osdl.org, pavel@ucw.cz, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mpm@selenic.com
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-Id: <20040811173935.5f23e348.davem@redhat.com>
In-Reply-To: <23701.1092268910@ocs3.ocs.com.au>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org>
	<23701.1092268910@ocs3.ocs.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 10:01:50 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> Tweak the profile code to detect that the instruction pointer is in the
> out of line spinlock code and replace the ip with the caller's ip.  We
> already do that for ia64, where the out of line spinlock code is a big
> win.  A kdb backtrace on an ia64 contended lock will even decode the
> address of the lock, which is only possible because the lock address is
> in a known location for this case.

We were doing this on sparc64 as well.
