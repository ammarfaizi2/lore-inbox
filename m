Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUGLVFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUGLVFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGLVFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:05:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262547AbUGLVFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:05:10 -0400
Date: Mon, 12 Jul 2004 14:04:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Charles R. Anderson" <cra@WPI.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.6 IGMPv3 implementation
Message-Id: <20040712140409.3575b900.davem@redhat.com>
In-Reply-To: <20040712203056.GI7822@angus.ind.WPI.EDU>
References: <20040712203056.GI7822@angus.ind.WPI.EDU>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 16:30:56 -0400
"Charles R. Anderson" <cra@WPI.EDU> wrote:

> /* Multicast source filter calls */
> #define SIOCSIPMSFILTER        0x89a0          /* set mcast src filter (ipv4) */
> #define SIOCGIPMSFILTER 0x89a1         /* get mcast src filter (ipv4) */
> #define SIOCSMSFILTER  0x89a2          /* set mcast src filter (proto indep) */
> #define SIOCGMSFILTER  0x89a3          /* get mcast src filter (proto indep) */
> 
> These do not appear in the Linus kernel, though.  Does anyone know the
> status of these ioctls and the IGMPv3 implementation in general?

We didn't use ioctls, we used socket options.  See:

include/linux/in.h

Specifically IP_MSFILTER and friends.

BTW, unlike you claim, the IGMPv3 stack implementation has been in the
kernel for a long time, much before 2.6.7  It is even in the current
2.4.x sources as well.
