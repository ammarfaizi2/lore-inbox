Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUL1WSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUL1WSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 17:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUL1WSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 17:18:41 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:16561
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261265AbUL1WSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 17:18:39 -0500
Date: Tue, 28 Dec 2004 14:17:10 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       openib-general@openib.org
Subject: Re: [PATCH][v5][0/24] Latest IB patch queue
Message-Id: <20041228141710.4daebcfb.davem@davemloft.net>
In-Reply-To: <52pt0unr0i.fsf@topspin.com>
References: <200412272150.IBRnA4AvjendsF8x@topspin.com>
	<20041227225417.3ac7a0a6.davem@davemloft.net>
	<52pt0unr0i.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 11:48:13 -0800
Roland Dreier <roland@topspin.com> wrote:

> Speaking of build failures, one of my test builds is cross-compiling
> for sparc64 with gcc 3.4.2, which adds __attribute__((warn_unused_result))
> to copy_to_user() et al.  The -Werror in the arch/sparc64 means the
> build fails with

Thanks, I'll check that out.

I believe that you didn't test the sparc64 build of the infiniband stuff
because arch/sparc64/Kconfig needs to explicitly include the infiniband
Kconfig since it does not use drivers/Kconfig.  You didn't send me any
such changes.

There are a few platforms which also are in this situation.
I added the sparc64 one to my tree while integrating your changes,
but the others need to be attended to if you wish infiniband to
be configurable on them.
