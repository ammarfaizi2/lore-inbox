Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTJHOUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 10:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTJHOUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 10:20:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20945 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261601AbTJHOUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 10:20:15 -0400
Date: Wed, 8 Oct 2003 07:11:59 -0700
From: "David S. Miller" <davem@redhat.com>
To: Tobias DiPasquale <toby@cbcg.net>
Cc: jgarzik@pobox.com, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
Message-Id: <20031008071159.586c5d3c.davem@redhat.com>
In-Reply-To: <1065622303.1512.41.camel@localhost>
References: <1065617075.1514.29.camel@localhost>
	<3F840C9C.9050704@pobox.com>
	<1065622303.1512.41.camel@localhost>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Oct 2003 10:11:43 -0400
Tobias DiPasquale <toby@cbcg.net> wrote:

> Well, I certainly have done that already ;-) But I have checked kfree()
> and vfree() and they have a sanity check for NULL before processing, as
> well as those are also the well-known semantics for the userspace free()
> call.

So what?  Those are totally different APIs and they in no way determine
how other interfaces should behave.

Passing NULL pointers around usually indicates poorly designed
software anyways (unless the NULL pointer is being returned by
a routine to indicate an allocation failure).

This isn't even worth discussing anymore.
