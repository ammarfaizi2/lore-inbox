Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUB0Gvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUB0Gvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:51:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13783 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261718AbUB0Gva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:51:30 -0500
Date: Thu, 26 Feb 2004 22:49:58 -0800
From: "David S. Miller" <davem@redhat.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: bunk@fs.tum.de, marcelo.tosatti@cyclades.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.26-pre1: SCTP compile error
Message-Id: <20040226224958.24eb29fb.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0402261533500.19577@localhost.localdomain>
References: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>
	<20040226212759.GV5499@fs.tum.de>
	<Pine.LNX.4.58.0402261533500.19577@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 15:53:58 -0800 (PST)
Sridhar Samudrala <sri@us.ibm.com> wrote:

> I missed this warning as i don't have irda enabled in my config.
> A simple fix would be to rename the macro in sctp.h to
> SCTP_MSECS_TO_JIFFIES.

I've fixed this in my tree.

> > ipv6.c: In function `sctp_v6_xmit':
> > ipv6.c:189: request for member `in6_u' in something not a structure or union
> > ipv6.c:189: request for member `in6_u' in something not a structure or union
> 
> I am not seeing these errors with either gcc3.2.2 or gcc2.96. But, looking at the
> code, this definitely seems to be a problem. Not sure why the newer versions of
> gcc didn't catch them.

It's trying to use NIP6() on an object that is not a struct in6_addr.
I'll just comment this thing out for now.
