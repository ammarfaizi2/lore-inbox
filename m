Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUGFXQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUGFXQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUGFXQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:16:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:11683 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264668AbUGFXQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:16:03 -0400
Date: Wed, 7 Jul 2004 01:16:00 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, ahu@ds9a.nl,
       acme@conectiva.com.br, netdev@oss.sgi.com, alessandro.suardi@oracle.com,
       phyprabab@yahoo.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040706231600.GA18181@wotan.suse.de>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org> <20040629222751.392f0a82.davem@redhat.com> <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net> <20040630153049.3ca25b76.davem@redhat.com> <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <20040706132426.097f71e6.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706132426.097f71e6.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would not change anything, just suggest that users who sit
behind such a broken device do

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

and yell loudly at their ISPs to get this fixed. Crippling the stack
by default just to work around such obvious bugs would be wrong.

In the past there were similar bugs with broken VJ header compression
algorithms that also corrupted window scaling. We just ignored
these and suggested to the users to turn it off. That worked fine.

[btw it's quite possible that this isn't a firewall, but also
some kind of header compression that is doing the wrong thing]

-Andi
