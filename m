Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272057AbTHSQFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTHSQEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:04:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16010 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271704AbTHSQEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:04:43 -0400
Date: Tue, 19 Aug 2003 08:57:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, richard@aspectgroup.co.uk, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819085717.56046afd.davem@redhat.com>
In-Reply-To: <20030819170751.2b92ba2e.skraw@ithnet.com>
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>
	<20030819145403.GA3407@alpha.home.local>
	<20030819170751.2b92ba2e.skraw@ithnet.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 17:07:51 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Hm, what rule is broken by the remote host, then?

It means that systems (like Linux) that make IP addresses owned by the
host instead of specific interfaces cannot correctly interoperate with
such remote systems.

It is also the case that a host cannot possibly be aware of all
subnets present on a given LAN, therefore is should be liberal in it's
replies to ARP requests.

Finally, it violates the most basic rule of IP networking:

"Be liberal in what you accept, and conservative in what you send"
-Jon Postel

In general, when a host posses the information necessary to allow
other hosts to communicate, it should provide that information
whenever possible.

