Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUFIUdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUFIUdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUFIUdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:33:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35500 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265953AbUFIUdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:33:32 -0400
Date: Wed, 9 Jun 2004 13:29:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-Id: <20040609132937.68866dfc.davem@redhat.com>
In-Reply-To: <1086812976.4288.50.camel@tdi>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
	<1086805676.4288.16.camel@tdi>
	<20040609130001.37a88da1.davem@redhat.com>
	<1086812976.4288.50.camel@tdi>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2004 14:29:36 -0600
Alex Williamson <alex.williamson@hp.com> wrote:

>    Which is probably why the patch never went anywhere.  There's
> certainly an alignment issue in the usage of the struct arpt_arp in the
> code snippet Christoph pointed out.  Sounds like it'd be better to fix
> the usage than the structure alignment.

Right.  I distinctly remember a similar fix being needed to
ip_tables.c many months ago, a search though the change history
for that file might prove profitable :-)
