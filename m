Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVDQUti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVDQUti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVDQUmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:42:33 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:33991
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261519AbVDQUmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:42:06 -0400
Date: Sun, 17 Apr 2005 13:36:20 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Avi Kivity <avi@argo.co.il>
Cc: arjan@infradead.org, andihartmann@01019freenet.de,
       linux-kernel@vger.kernel.org
Subject: Re: More performance for the TCP stack by using additional hardware
 chip on NIC
Message-Id: <20050417133620.04b4698d.davem@davemloft.net>
In-Reply-To: <1113733753.15803.26.camel@avik.scalemp>
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
	<1113728880.17394.16.camel@laptopd505.fenrus.org>
	<1113733753.15803.26.camel@avik.scalemp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2005 13:29:14 +0300
Avi Kivity <avi@argo.co.il> wrote:

> TOEs can remove the data copy on receive. In some applications (notably
> storage), where the application does not touch most of the data, this is
> a significant advantage that cannot be achieved in a software-only
> solution.

You don't need to offload the TCP stack to make this case get
zero-copy behavior.
