Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759118AbWLFFt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118AbWLFFt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760123AbWLFFt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:56904 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759126AbWLFFt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:49:58 -0500
Date: Tue, 5 Dec 2006 21:49:41 -0800
From: Greg KH <gregkh@suse.de>
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device naming randomness (udev?)
Message-ID: <20061206054941.GD13118@suse.de>
References: <45735230.7030504@mbligh.org> <20061203231206.GA4413@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203231206.GA4413@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 12:12:06AM +0100, Bj?rn Steinbrink wrote:
> On 2006.12.03 14:39:44 -0800, Martin J. Bligh wrote:
> > This PC has 1 ethernet interface, an e1000. Ubuntu Dapper.
> > 
> > On 2.6.14, my e1000 interface appears as eth0.
> > On 2.6.15 to 2.6.18, my e1000 interface appears as eth1.
> > 
> > In both cases, there are no other ethX interfaces listed in
> > "ifconfig -a". There are no modules involved, just a static
> > kernel build.
> > 
> > Is this a bug in udev, or the kernel? I'm presuming udev,
> > but seems odd it changes over a kernel release boundary.
> > Any ideas on how I get rid of it? Makes automatic switching
> > between kernel versions a royal pain in the ass.
> 
> Just a wild guess here... Debian's (and I guess Ubuntu's) udev rules
> contain a generator for persistent interface name rules. Maybe these
> start working with 2.6.15 and thus the switch (ie. the kernel would call
> it eth0, but udev renames it to eth1).
> The generated rules are written to
> /etc/udev/rules.d/z25_persistent-net.rules on Debian, not sure if its
> the same for Ubuntu. Editing/removing the rules should fix your problem.

Yes, I'd place odds on this one.

Martin, any followup?

thanks,

greg k-h
