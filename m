Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUGFTko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUGFTko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUGFTko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:40:44 -0400
Received: from mail.shareable.org ([81.29.64.88]:25520 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264358AbUGFTkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:40:42 -0400
Date: Tue, 6 Jul 2004 20:40:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040706194034.GA11021@mail.shareable.org>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org> <20040629222751.392f0a82.davem@redhat.com> <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net> <20040630153049.3ca25b76.davem@redhat.com> <20040701133738.301b9e46@dell_ss3.pdx.osdl.net> <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Recent TCP changes exposed the problem that there ar lots of really
> broken firewalls that strip or alter TCP options.  When the options
> are modified TCP gets busted now.  The problem is that when we
> propose window scaling, we expect that the other side receives the
> same initial SYN request that we sent.  If there is corrupting
> firewalls that strip it then the window we send is not correctly
> scaled; so the other side thinks there is not enough space to send.

If a firewall strips the window scaling option in both directions,
then window scaling is disabled (RFC 1323 section 2.2).

Are you saying there are broken firewalls which strip TCP options in
one direction only?

-- Jamie
