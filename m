Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWH3ErK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWH3ErK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 00:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWH3ErK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 00:47:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53151 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964968AbWH3ErI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 00:47:08 -0400
Date: Tue, 29 Aug 2006 21:45:43 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
Message-ID: <20060830044543.GA14738@kroah.com>
References: <20060829073339.GA4181@aehallh.com> <1156839019.2722.39.camel@laptopd505.fenrus.org> <20060829084443.GA4187@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829084443.GA4187@aehallh.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 04:44:43AM -0400, Zephaniah E. Hull wrote:
> On Tue, Aug 29, 2006 at 10:10:19AM +0200, Arjan van de Ven wrote:
> > > +#undef DEBUG
> > > +#ifdef DEBUG
> > > +#define dbg(format, arg...) printk(KERN_INFO "olpc.c(%d): " format "\n", __LINE__, ## arg)
> > > +#else
> > > +#define dbg(format, arg...) do {} while (0)
> > > +#endif
> > 
> > why not use pr_debug or even dev_debug() ?
> > Those already have this ifdef included
> 
> I was not thinking of them at the time, however dev_dbg is not an option
> because we do not have a struct device at hand when we want to print
> some debugging lines.

Then use it for the majority of the places where you do have it, and do
pr_debug() when you do not.

> pr_debug might work, but I would rather have file and line already
> there.
> 
> Though, admittedly, that would be a better argument if it used __FILE__
> there instead of hard coding it.

__FILE__ will return you a full path, which is what I do not think you
want...

thanks,

greg k-h
