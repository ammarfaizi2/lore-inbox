Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWEIUaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWEIUaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWEIUaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:30:01 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64129 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751134AbWEIUaA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:30:00 -0400
Date: Tue, 9 May 2006 13:32:59 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       netdev@vger.kernel.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Message-ID: <20060509203259.GT24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085201.446830000@sous-sol.org> <20060509132556.76deaa91@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509132556.76deaa91@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Hemminger (shemminger@osdl.org) wrote:
> > +	info->irq = bind_evtchn_to_irqhandler(
> > +		info->evtchn, netif_int, SA_SAMPLE_RANDOM,
> > netdev->name,
> 
> This doesn't look like a real random entropy source. packets
> arriving from another domain are easily timed.

Heh, given the path they take, that sadly may not be the case ;-)
But point well-taken, that's easy to drop.

thanks,
-chris
