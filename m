Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUEHWHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUEHWHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbUEHWFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:05:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6028 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264196AbUEHWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:04:58 -0400
Date: Sat, 8 May 2004 15:04:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: hch@infradead.org, sds@epoch.ncsc.mil, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 2/2 sock_create_lite()
Message-Id: <20040508150432.3856573c.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0405071531480.22499-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0405071118490.21529-100000@thoron.boston.redhat.com>
	<Xine.LNX.4.44.0405071531480.22499-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004 15:53:30 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> Ok, here's a version of this patch which doesn't do anything with 
> sock_alloc().

Applied, although I had to hand-edit the patch since you
accidently included the following bit from the first SELINUX
patch of this series :-)

> -	err = sock_create(family, SOCK_SEQPACKET, IPPROTO_SCTP,
> -			  &sctp_ctl_socket);
> +	err = sock_create_kern(family, SOCK_SEQPACKET, IPPROTO_SCTP,
> +			       &sctp_ctl_socket);
