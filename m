Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272521AbTHSSKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272447AbTHSSIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:08:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16012 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272623AbTHSSAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:00:37 -0400
Date: Tue, 19 Aug 2003 10:53:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819105307.0b0a6491.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB5C@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB5C@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 18:56:18 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> 	Which nicely sums up the bug, really.

Ok, then how would you propose to be able to send
packets out an interface _before_ we have addresses
assigned to it?

Linux allows that, and in fact it's a useful feature.

Consider MSG_DONTROUTE as well.

BTW, this ARP source address algorithm we use comes from
ipv6, it would be instructive to go and see why they do
things the way they do.
