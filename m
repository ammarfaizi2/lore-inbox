Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWCJQzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWCJQzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWCJQzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:55:09 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:60820
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751193AbWCJQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:55:07 -0500
Date: Fri, 10 Mar 2006 08:54:52 -0800
From: Greg KH <gregkh@suse.de>
To: Hal Rosenstock <halr@voltaire.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       davem@davemloft.net
Subject: Re: [openib-general] Re: [PATCH 8 of 20] ipath - sysfs support for core driver
Message-ID: <20060310165452.GA11382@suse.de>
References: <patchbomb.1141950930@eng-12.pathscale.com> <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com> <20060310011106.GD9945@suse.de> <1141967377.14517.32.camel@camp4.serpentine.com> <20060310063724.GB30968@suse.de> <adairqmbb24.fsf@cisco.com> <1142003287.4331.28584.camel@hal.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142003287.4331.28584.camel@hal.voltaire.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 10:08:10AM -0500, Hal Rosenstock wrote:
> On Fri, 2006-03-10 at 09:59, Roland Dreier wrote:
> >     Greg> The main issue is that if you create a sysfs file like this,
> >     Greg> and then in 3 months realize that you need to change one of
> >     Greg> those characters to be something else, you are in big
> >     Greg> trouble...
> > 
> > I think that PortInfo and NodeInfo might be fair game for sysfs files,
> > because they are actually defined in the IB spec with a binary format
> > that is sent on the wire.  So they're not going to change.
> 
> Not true; There have been and likely will be more upward compatible
> changes (especially to PortInfo).

Great, that means they should NOT be exported to userspace in this
fashion...

> > On the other hand it's not clear to me why using that wire protocol as
> > an interface to userspace is a good idea...

Agreed.

thanks,

greg k-h
