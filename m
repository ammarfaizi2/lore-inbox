Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTEGGdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTEGGdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:33:31 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:18441 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262914AbTEGGda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:33:30 -0400
Date: Wed, 7 May 2003 07:45:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Horsten <thomas@horsten.com>
Cc: "ismail (cartman) donmez" <voidcartman@yahoo.com>,
       "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030507074557.A9197@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Horsten <thomas@horsten.com>,
	"ismail (cartman) donmez" <voidcartman@yahoo.com>,
	"David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <20030506104956.A29357@infradead.org> <200305061640.13360.thomas@horsten.com> <200305070850.59912.voidcartman@yahoo.com> <200305070744.27207.thomas@horsten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305070744.27207.thomas@horsten.com>; from thomas@horsten.com on Wed, May 07, 2003 at 07:44:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:44:27AM +0100, Thomas Horsten wrote:
> However I do not agree with that - I think it makes total sense for userland 
> to include kernel headers when we are talking e.g. specific device driver 
> interface. Imagine Joe Admin has firewall which is a pretty old Slackware 
> with 2.2 kernel and wants to upgrade to 2.4 to get from ipchains to iptables 
> (all just an example). He just downloads the 2.4 kernel and builds it, 
> symlinks to /usr/src/linux so his /usr/include/linux and ../asm will point to 
> the new kernel then he goes on to build the iptables userland binary - oops,

That's highly broken because his libc was compiled against 2.2 headers.
You must never use different headers in /usr/include/Pasm,linux} then those
your libc was compiled against.

