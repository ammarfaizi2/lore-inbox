Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUCVHOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 02:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbUCVHOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 02:14:44 -0500
Received: from test.estpak.ee ([194.126.115.47]:9726 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S261795AbUCVHOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 02:14:42 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: Paul Jakma <paul@clubi.ie>
Subject: Re: raw sockets and blocking
Date: Mon, 22 Mar 2004 09:14:13 +0200
User-Agent: KMail/1.6.2
Cc: Jamie Lokier <jamie@shareable.org>, David Schwartz <davids@webmaster.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Quagga Dev <quagga-dev@lists.quagga.net>
References: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com> <200402191440.01035.hasso@estpak.ee> <Pine.LNX.4.58.0402191252010.25392@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.58.0402191252010.25392@fogarty.jakma.org>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403220914.13676.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> On Thu, 19 Feb 2004, Hasso Tepper wrote:
> > And maybe it makes sense to mention that all packets ospf daemon
> > sends to actually down ethernet interface are multicast packets.
>
> nearly all. unicast packets are sent too.

Hello's in broadcast network are multicast. Problem is solved now for 
me, btw. It appears to be bug in e100 driver in 2.4.x.

I can't reproduce it any more with e100 development driver (from 
http://sf.net/projects/e1000/). And I can't it reproduce it with 
forcing network to non-broadcast either (in this case unicast hello's 
are sent).

So it's multicast problem with e100 2.x driver.


-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
