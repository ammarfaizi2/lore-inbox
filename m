Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272585AbTG1AuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272604AbTG1AtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:49:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35507 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272585AbTG1Any (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:43:54 -0400
Date: Sun, 27 Jul 2003 17:55:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727175557.1d624b36.davem@redhat.com>
In-Reply-To: <200307280253090799.10BB2DF0@192.168.128.16>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
	<200307280140470646.1078EC67@192.168.128.16>
	<20030727164649.517b2b88.davem@redhat.com>
	<200307280158250677.10891156@192.168.128.16>
	<20030727165831.05904792.davem@redhat.com>
	<200307280211590888.10957DD9@192.168.128.16>
	<20030727171403.6e5bcc58.davem@redhat.com>
	<200307280235210263.10AADFF8@192.168.128.16>
	<20030727173600.475d95fb.davem@redhat.com>
	<200307280253090799.10BB2DF0@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 02:53:09 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> But if the hidden patch and /proc switch would be in the main kernel,
> it would be the simpliest way to solve all these "problems" (with an
> echo "1" and without filtering or using iproute2).

With or without your suggestion, people have to do something
different.

This doesn't even address all the problems there are with
the hidden patch.  It does things that belong on the netfilter
level and not on the ARP/routing level.

Again, I'd like you to read all the discussions that have happened on
this topic in the past, in particular those made by Alexey Kuznetsov
on this topic.  He gives very clear and concise reasons why the
"hidden" patch is logically doing things in the wrong part of the
kernel, and therefore won't ever be put into the tree.
