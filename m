Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUDWXnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUDWXnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUDWXnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:43:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34457 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261746AbUDWXnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:43:02 -0400
Date: Fri, 23 Apr 2004 16:42:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: jmorris@redhat.com, Matt_Domsch@dell.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/libcrc32c, revised 040419
Message-Id: <20040423164226.3d6fa2c3.davem@redhat.com>
In-Reply-To: <yqujpta3y7ia.fsf_-_@chaapala-lnx2.cisco.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<yqujr7vai6k4.fsf@chaapala-lnx2.cisco.com>
	<200403302043.22938.bzolnier@elka.pw.edu.pl>
	<yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
	<20040330192350.GB5149@lists.us.dell.com>
	<yquj1xn87mpy.fsf_-_@chaapala-lnx2.cisco.com>
	<yqujpta3y7ia.fsf_-_@chaapala-lnx2.cisco.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 16:37:01 -0500
Clay Haapala <chaapala@cisco.com> wrote:

> +#if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
> +#define attribute(x) __attribute__(x)
> +#else
> +#define attribute(x)
> +#endif

I was about to apply your two patches, but then I noticed this
thing.  WHatever you may need this for exists in linux/compiler.h
and if it doesn't you should add the necessary macro interfaces
there.

Thanks.
