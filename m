Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271099AbUJUX6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271099AbUJUX6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbUJUX4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:56:49 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63406
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S271099AbUJUXqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:46:13 -0400
Date: Thu, 21 Oct 2004 16:40:07 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       jgarzik@pobox.com, gnb@sgi.com, akepner@sgi.com
Subject: Re: [PATCH] use mmiowb in tg3.c
Message-Id: <20041021164007.4933b10b.davem@davemloft.net>
In-Reply-To: <200410211628.06906.jbarnes@engr.sgi.com>
References: <200410211613.19601.jbarnes@engr.sgi.com>
	<200410211628.06906.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 16:28:06 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> This patch originally from Greg Banks.  Some parts of the tg3 driver depend on 
> PIO writes arriving in order.  This patch ensures that in two key places 
> using the new mmiowb macro.  This not only prevents bugs (the queues can be 
> corrupted), but is much faster than ensuring ordering using PIO reads (which 
> involve a few round trips to the target bus on some platforms).

Do other PCI systems which post PIO writes also potentially reorder
them just like this SGI system does?  Just trying to get this situation
straight in my head.

