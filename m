Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268764AbUIGX3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268764AbUIGX3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268767AbUIGX3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:29:44 -0400
Received: from waste.org ([209.173.204.2]:24010 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268764AbUIGX3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:29:35 -0400
Date: Tue, 7 Sep 2004 18:29:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: Duncan Sands <baldrick@free.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netpoll endian fixes
Message-ID: <20040907232927.GB31237@waste.org>
References: <200409080124.43530.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409080124.43530.baldrick@free.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 01:24:43AM +0200, Duncan Sands wrote:
> The big-endians took their revenge in netpoll.c: on i386,
> the ip header length / version nibbles need to be the other
> way round; and the htonl leaves only zeros in tot_len...

I'm completely baffled as to how length / version nibbles could be
swapped. Endianness here should be a matter of _bytes_.

The htons seems reasonable.

-- 
Mathematics is the supreme nostalgia of our time.
