Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWEIXdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWEIXdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWEIXdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:33:18 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38786 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932072AbWEIXdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:33:17 -0400
Date: Tue, 9 May 2006 16:35:43 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: David Boutcher <boutcher@us.ibm.com>
Cc: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, chrisw@sous-sol.org,
       Herbert Xu <herbert@gondor.apana.org.au>, ian.pratt@xensource.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual	network	device	driver.
Message-ID: <20060509233543.GG24291@moss.sous-sol.org>
References: <20060509140027.GD7834@cl.cam.ac.uk> <OFE128D80F.BD59DF3E-ON86257169.004F91EA-86257169.004F6870@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE128D80F.BD59DF3E-ON86257169.004F91EA-86257169.004F6870@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Boutcher (boutcher@us.ibm.com) wrote:
> Then make a generic solution.  VMWare supports migration, the Power 
> virtualization will get around to it eventually.  All will need something
> similar.  So either make a common user-land tool, or (if you insist on
> incorrectly driving this into the kernel) add some kind of common hook to
> the TCP/IP stack.

I'm not that fond of the in-kernel solution either.  HA failover does
this stuff in userspace, and has the same gratuitous arp requirements.
Perhaps we should see some numbers showing the migration latency
introduced.  At the very least, it's easy to factor out as suggested.

thanks,
-chris
