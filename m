Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWCGRVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWCGRVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCGRVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:21:07 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:65470
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751335AbWCGRVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:21:06 -0500
Date: Tue, 7 Mar 2006 09:20:54 -0800
From: Greg KH <greg@kroah.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060307172054.GA7293@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061014.22312.dsp@llnl.gov> <20060306102232.613911f6.rdunlap@xenotime.net> <200603070903.19226.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603070903.19226.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:03:19AM -0800, Dave Peterson wrote:
> On Monday 06 March 2006 10:22, Randy.Dunlap wrote:
> > On Mon, 6 Mar 2006 10:14:22 -0800 Dave Peterson wrote:
> > > On Sunday 05 March 2006 02:30, Arjan van de Ven wrote:
> > > > On Sun, 2006-03-05 at 11:18 +0100, Arjan van de Ven wrote:
> > > > > > +/* Main MC kobject release() function */
> > > > > > +static void edac_memctrl_master_release(struct kobject *kobj)
> > > > > > +{
> > > > > > +	debugf1("EDAC MC: " __FILE__ ": %s()\n", __func__);
> > > > > > +}
> > > > > > +
> > > > >
> > > > > ehhh how on earth can this be right?
> > > >
> > > > oh and this stuff also violates the "one value per file" rule; can we
> > > > fix that urgently before it becomes part of the ABI in 2.6.16??
> > >
> > > Ok, I'll admit to being a bit clueless about this.  I'm not familiar
> > > with the "one value per file" rule; can someone please explain?
> >
> > it's in Documentation/filesystems/sysfs.txt
> > Strongly preferred.
> 
> Ok, I assume the comment refers to the following:
> 
>     Attributes should be ASCII text files, preferably with only one value
>     per file. It is noted that it may not be efficient to contain only
>     value per file, so it is socially acceptable to express an array of
>     values of the same type.
> 
> I was initially a bit confused because I thought the comment
> specifically pertained to the piece of code shown above.  I need to
> take a closer look at the EDAC sysfs code - I'm not as familiar with
> some of its details as I should be.  Thanks for pointing out the
> issue.

How else should we word the above text so that people realize that it
pertains to them?  You aren't the first person to ignore it, so there is
a real problem here :(

thanks,

greg k-h
