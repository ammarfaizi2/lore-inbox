Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUH0XrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUH0XrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUH0Xq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:46:57 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:56705
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266737AbUH0Xqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:46:46 -0400
Date: Fri, 27 Aug 2004 16:43:06 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: clameter@sgi.com, akpm@osdl.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, benh@kernel.crashing.org,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040827164306.2b764700.davem@davemloft.net>
In-Reply-To: <20040827233602.GB1024@wotan.suse.de>
References: <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
	<20040815165827.0c0c8844.davem@redhat.com>
	<Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com>
	<20040815185644.24ecb247.davem@redhat.com>
	<Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004 01:36:02 +0200
Andi Kleen <ak@suse.de> wrote:

> On some architectures it used to be 24bit only even, but I think that
> has been fixed.

It has, on sparc32 the hashed spinlock scheme is being used
so it's a full 32-bit counter now.

Well, it's not even 32-bits, it's actually 31-bits since the
value is declared as signed.

Only 64-bit platforms provide the atomic64_t implementation.
We'd need to deal with that before making your suggested
change.
