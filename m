Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbULGS4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbULGS4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbULGS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:56:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:48256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261889AbULGS4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:56:38 -0500
Date: Tue, 7 Dec 2004 10:56:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: yoshfuji@linux-ipv6.org, mitch@sfgoth.com, kernel@linuxace.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] fix select() for SOCK_RAW sockets (ipv6)
Message-Id: <20041207105620.241652d0@dxpl.pdx.osdl.net>
In-Reply-To: <20041207104815.3f7a4684.davem@davemloft.net>
References: <20041207045302.GA23746@linuxace.com>
	<20041207054840.GD61527@gaz.sfgoth.com>
	<20041207150834.GA75700@gaz.sfgoth.com>
	<20041208.023530.26430801.yoshfuji@linux-ipv6.org>
	<20041207100140.781f4c00@dxpl.pdx.osdl.net>
	<20041207104815.3f7a4684.davem@davemloft.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004 10:48:15 -0800
"David S. Miller" <davem@davemloft.net> wrote:

> On Tue, 7 Dec 2004 10:01:40 -0800
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > > Probably, we need to do the same for ipv6, don't we?
> > 
> > diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> > --- a/net/ipv6/af_inet6.c	2004-12-07 10:02:50 -08:00
> > +++ b/net/ipv6/af_inet6.c	2004-12-07 10:02:50 -08:00
> > @@ -513,6 +513,27 @@
> 
> We didn't do the "UDP select() fix" on ipv6 because we don't
> have the delayed checksumming optimization there.  So the
> ipv6 side really doesn't need this change.
> 
> Or did I miss something?

yeah, didn't look that deeply.
