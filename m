Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWJGFcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWJGFcL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWJGFcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:32:11 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:52701 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751744AbWJGFcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:32:09 -0400
Date: Sat, 7 Oct 2006 01:32:06 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Bill Fink <billfink@mindspring.com>
cc: Joerg Roedel <joro-lkml@zlug.org>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
In-Reply-To: <20061007010517.3b9db240.billfink@mindspring.com>
Message-ID: <Pine.LNX.4.64.0610070131390.15387@d.namei>
References: <20061006093402.GA12460@zlug.org> <20061006.215935.92667295.yoshfuji@linux-ipv6.org>
 <20061006151556.GA15637@zlug.org> <20061007010517.3b9db240.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006, Bill Fink wrote:

> On Fri, 6 Oct 2006 17:15:56 +0200, Joerg Roedel wrote:
> 
> > +config IPV6_SIT
> > +	tristate "IPv6: IPv6-in-IPv4 tunnel (SIT driver)"
> > +	depends on IPV6
> > +	default y
> > +	---help---
> > +	  Tunneling means encapsulating data of one protocol type within
> > +	  another protocol and sending it over a channel that understands the
> > +	  encapsulating protocol. This driver implements encapsulation of IPv6
> > +	  into IPv4 packets. This is useful if you want to connect two IPv6
> > +	  networks over an IPv4-only path.
> > +
> > +	  Saying M here will produce a module called sit.ko. If unsure, say N.
> 
> >From a user perspective, I believe it should say "If unsure, say Y".
> The unsure case for the unsure user should be the case that works for
> the broadest possible usage spectrum, which would be the 'Y' case.
> To put it another way, if you pick 'Y' and don't really need it, the
> only downside is wasting some memory.  But if you pick 'N' and actually
> did need it, previously working IPv6 networking would no longer work.
> I believe the default setting should match the unsure recommendation.

Yes, the unsure value should match the default.  People pick the default 
because they're unsure.



-- 
James Morris
<jmorris@namei.org>
