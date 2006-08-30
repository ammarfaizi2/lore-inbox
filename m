Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWH3RYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWH3RYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWH3RYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:24:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:141 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751181AbWH3RYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:24:01 -0400
Date: Wed, 30 Aug 2006 10:22:46 -0700
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] PM: Add pm_trace switch
Message-ID: <20060830172246.GD4534@kroah.com>
References: <200608291309.57404.rjw@sisk.pl> <20060829134648.451971a1.akpm@osdl.org> <200608301202.59300.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608301202.59300.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 12:02:59PM +0200, Rafael J. Wysocki wrote:
> On Tuesday 29 August 2006 22:46, Andrew Morton wrote:
> > On Tue, 29 Aug 2006 13:09:57 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > +int pm_trace_enabled;
> > > +
> > > +static ssize_t pm_trace_show(struct subsystem * subsys, char * buf)
> > > +{
> > > +	return sprintf(buf, "%d\n", pm_trace_enabled);
> > > +}
> > > +
> > > +static ssize_t
> > > +pm_trace_store(struct subsystem * subsys, const char * buf, size_t n)
> > > +{
> > > +	int val;
> > > +
> > > +	if (sscanf(buf, "%d", &val) == 1) {
> > > +		pm_trace_enabled = !!val;
> > > +		return n;
> > > +	}
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +power_attr(pm_trace);
> > 
> > <grumbles about documentation>
> 
> Well, this is the most difficult part. ;-)
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  Documentation/power/interface.txt |   15 +++++++++++++++

Please update Documentation/ABI/ too.

thanks,

greg k-h
