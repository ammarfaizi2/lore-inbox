Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUIMXVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUIMXVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269059AbUIMXVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:21:05 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59303
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269057AbUIMXVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:21:02 -0400
Date: Mon, 13 Sep 2004 16:19:12 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: i@stingr.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Support for wccp version 1 and 2 in ip_gre.c
Message-Id: <20040913161912.7dcc809f.davem@davemloft.net>
In-Reply-To: <20040913051706.GB26337@stingr.sgu.ru>
References: <20040911194108.GS28258@stingr.sgu.ru>
	<20040912170505.62916147.davem@davemloft.net>
	<20040913051706.GB26337@stingr.sgu.ru>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 09:17:06 +0400
Paul P Komkoff Jr <i@stingr.net> wrote:

> Replying to David S. Miller:
> > What are the rules for IP_GRE in general for when
> > to apply this transformation?
> 
> As you can see, I am applying it unconditionally when fits. For most
> cases, this will be OK.
> There can be situations when this is not wanted (for example, when 
> debugging something), so in general, tuning knob will be useful, but 
> I just don't know where to add it, maybe tunnel->parms.i_flags ...

I don't think adding such a knob is necessary, but yes i_flags
would be the place to do it.

I will apply your patch with the "if(1)" simply removed.

Thanks.
