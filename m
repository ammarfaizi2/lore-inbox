Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVCJXv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVCJXv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263404AbVCJXv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:51:28 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:65436
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263397AbVCJXtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:49:08 -0500
Date: Thu, 10 Mar 2005 15:47:16 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: greg@kroah.com, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [06/11] [TCP]: Put back tcp_timer_bug_msg[] symbol export.
Message-Id: <20050310154716.5694bf69.davem@davemloft.net>
In-Reply-To: <20050310232014.GA32228@infradead.org>
References: <20050310230519.GA22112@kroah.com>
	<20050310230843.GG22112@kroah.com>
	<20050310232014.GA32228@infradead.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 23:20:14 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> > --- a/net/ipv4/tcp_timer.c	2005-03-09 17:20:38 -08:00
> > +++ b/net/ipv4/tcp_timer.c	2005-03-09 17:20:38 -08:00
> > @@ -38,6 +38,7 @@
> >  
> >  #ifdef TCP_DEBUG
> >  const char tcp_timer_bug_msg[] = KERN_DEBUG "tcpbug: unknown timer value\n";
> > +EXPORT_SYMBOL(tcp_timer_bug_msg);
> >  #endif
> 
> not complaining about putting this into -stable, but why do people have
> TCP_DEBUG turned on for normal builds?

It is on in everyone's build unless they edit include/net/tcp.h
