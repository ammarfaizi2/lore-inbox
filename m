Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUEGWB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUEGWB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUEGWB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:01:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263817AbUEGWBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:01:23 -0400
Date: Fri, 7 May 2004 15:01:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/crc32c.c (was Re: CRC32c warning on sparc64)
Message-Id: <20040507150108.7f909b3c.davem@redhat.com>
In-Reply-To: <yqujr7tx1gzz.fsf@chaapala-lnx2.cisco.com>
References: <Pine.GSO.4.44.0405061921290.21792-100000@math.ut.ee>
	<yqujr7tx1gzz.fsf@chaapala-lnx2.cisco.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2004 14:40:32 -0500
Clay Haapala <chaapala@cisco.com> wrote:

> Well, it's my opinion that using "size_t" is correct usage of type in
> this case.  So here's my thinking:
> 
> * we leave lib/crc32c() as it is with size_t, as it is meant to be
> derived from crc32() and that uses size_t.
> 
> * crypto/crc32c is a wrapper for lib/crc32c.  The interface it
> presents to the rest of the crypto routines should agree.  My bad.
> So, let us let it translate with a cast, as in the patch below.

This works for me, patch applied.
