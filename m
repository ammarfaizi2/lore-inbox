Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWJGFFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWJGFFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWJGFFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:05:42 -0400
Received: from elasmtp-scoter.atl.sa.earthlink.net ([209.86.89.67]:3303 "EHLO
	elasmtp-scoter.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751693AbWJGFFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:05:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=uATbmmxiiol2vgdMJzvA3dy1QGl9WIcTlEF6o16K1w9BhONRQ6p71FLo/y/djTHy;
  h=Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Date: Sat, 7 Oct 2006 01:05:16 -0400
From: Bill Fink <billfink@mindspring.com>
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
Message-Id: <20061007010517.3b9db240.billfink@mindspring.com>
In-Reply-To: <20061006151556.GA15637@zlug.org>
References: <20061006093402.GA12460@zlug.org>
	<20061006.215935.92667295.yoshfuji@linux-ipv6.org>
	<20061006151556.GA15637@zlug.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; powerpc-yellowdog-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: c598f748b88b6fd49c7f779228e2f6aeda0071232e20db4dc676853b8c459d60cebadcb608fd178d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.55.21.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 17:15:56 +0200, Joerg Roedel wrote:

> +config IPV6_SIT
> +	tristate "IPv6: IPv6-in-IPv4 tunnel (SIT driver)"
> +	depends on IPV6
> +	default y
> +	---help---
> +	  Tunneling means encapsulating data of one protocol type within
> +	  another protocol and sending it over a channel that understands the
> +	  encapsulating protocol. This driver implements encapsulation of IPv6
> +	  into IPv4 packets. This is useful if you want to connect two IPv6
> +	  networks over an IPv4-only path.
> +
> +	  Saying M here will produce a module called sit.ko. If unsure, say N.

>From a user perspective, I believe it should say "If unsure, say Y".
The unsure case for the unsure user should be the case that works for
the broadest possible usage spectrum, which would be the 'Y' case.
To put it another way, if you pick 'Y' and don't really need it, the
only downside is wasting some memory.  But if you pick 'N' and actually
did need it, previously working IPv6 networking would no longer work.
I believe the default setting should match the unsure recommendation.

						-Bill
