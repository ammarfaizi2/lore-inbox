Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbUKRXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUKRXCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUKRXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:02:24 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:49297
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262943AbUKRW7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:59:23 -0500
Date: Thu, 18 Nov 2004 14:43:47 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: ananth@in.ibm.com, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       prasanna@in.ibm.com, suparna@in.ibm.com
Subject: Re: [PATCH] Kprobes: wrapper to define jprobe.entry
Message-Id: <20041118144347.27008df7.davem@davemloft.net>
In-Reply-To: <20041118144746.7daa9395.akpm@osdl.org>
References: <20041118102641.GB8830@in.ibm.com>
	<20041118144746.7daa9395.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 14:47:46 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Ananth N Mavinakayanahalli <ananth@in.ibm.com> wrote:
> > Changes for adding this wrapper for x86, ppc64 (tested) and x86_64 
> > (untested) below. The earlier method of defining jprobe.entry will
> > continue to work.
> 
> So what should I do with this?  I'm inclined to drop it until the x86_64
> part has been tested and Dave has had a go at the sparc64 version.

Yes, now that we have kprobe support on 4 platforms, it is important
that anyone who changes public parts of this interface do the necessary
per-platform fixups necessary to coincide with such changes.

I think the person changing the data type should be the one fixing
up sparc64 :-)
