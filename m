Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269529AbUHZUJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269529AbUHZUJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269555AbUHZUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:06:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39576 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269553AbUHZUBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:01:09 -0400
Date: Thu, 26 Aug 2004 13:00:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: netfilter IPv6 support
Message-Id: <20040826130024.6ff83dff.davem@redhat.com>
In-Reply-To: <1093546367.3497.23.camel@hostmaster.org>
References: <1093546367.3497.23.camel@hostmaster.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 20:52:47 +0200
Thomas Zehetbauer <thomasz@hostmaster.org> wrote:

> Although linux was one of the first to support IPv6 it seems to me that
> netfilter support has almost stuck. There is still not even a REJECT
> target not to mention stateful filtering for IPv6.

Why not ask the netfilter development lists such questions?

Stateful netfilter is not there because it's a total waste
to completely duplicate all of the connection tracking et al.
code into ipv6 counterparts when %80 of the code is roughly
the same.  People are working on a consolidation of these
things so that there is no code duplication but it is a lot
of work and there are bigger fires to put out at the moment.
