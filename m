Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275822AbTHSQVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275834AbTHSQVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:21:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32138 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275822AbTHSQVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:21:35 -0400
Date: Tue, 19 Aug 2003 09:14:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: willy@w.ods.org, richard@aspectgroup.co.uk, alan@lxorguk.ukuu.org.uk,
       skraw@ithnet.com, carlosev@newipnet.com, lamont@scriptkiddie.org,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819091414.512d80c4.davem@redhat.com>
In-Reply-To: <Pine.LNX.3.96.1030819114722.6826F-100000@gatekeeper.tmr.com>
References: <20030819145403.GA3407@alpha.home.local>
	<Pine.LNX.3.96.1030819114722.6826F-100000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 11:53:29 -0400 (EDT)
Bill Davidsen <davidsen@tmr.com> wrote:

> I wonder if a change to add a flag preventing *any* packet from being sent
> on a NIC which doesn't have the proper source address would be politically
> acceptable.

This would disable things like MSG_DONTROUTE and many valid
uses of RAW sockets.
