Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWEHSCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWEHSCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWEHSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:02:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:12448 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932430AbWEHSCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:02:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rD+6MlOUp9rza95wTGcjkDjQTKe6SswVyY9BKppFHV7RC+KBHmYLKROMuHENaWIsTsob5HMzTQ3hT+4Ztu9RgvBzD8pcSljW9xyM9u0uDZ5Ysih0uRMZq/uD8SwNwBvtAFYxnv6dNuq7j7OqW/H7/NYcYcCouldQK291FU330kU=
Date: Mon, 8 May 2006 22:01:17 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, arjan@linux.intel.com, greg@kroah.com
Subject: Re: [patch] add new uevent
Message-ID: <20060508180117.GA7235@mipter.zuzino.mipt.ru>
References: <1146867216.21633.6.camel@whizzy> <20060505222234.GA7238@mipter.zuzino.mipt.ru> <1147109089.3094.1.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147109089.3094.1.camel@whizzy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 10:24:49AM -0700, Kristen Accardi wrote:
> On Sat, 2006-05-06 at 02:22 +0400, Alexey Dobriyan wrote:
> > On Fri, May 05, 2006 at 03:13:36PM -0700, Kristen Accardi wrote:
> > > Add dock uevents so that userspace can be notified of dock and undock
> > > events.
> >
> > > --- 2.6-git-kca2.orig/include/linux/kobject.h
> > > +++ 2.6-git-kca2/include/linux/kobject.h
> > > @@ -46,6 +46,8 @@ enum kobject_action {
> > >  	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
> > >  	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
> > >  	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
> > > +	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	/* undocking */
> > > +	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	/* dock */
> > >  };
> > >
> > >  struct kobject {
> > > --- 2.6-git-kca2.orig/lib/kobject_uevent.c
> > > +++ 2.6-git-kca2/lib/kobject_uevent.c
> > > @@ -48,6 +48,10 @@ static char *action_to_string(enum kobje
> > >  		return "offline";
> > >  	case KOBJ_ONLINE:
> > >  		return "online";
> > > +	case KOBJ_DOCK:
> > > +		return "dock";
> > > +	case KOBJ_UNDOCK:
> > > +		return "undock";
> > >  	default:
> > >  		return NULL;
> > >  	}
> >
> > Where exactly are you going to generate them?
>
> Hi Alexey,
> These events will be generated from the dock driver.  The patch for this
> will be submitted in the next day or 2 (assuming everyone is ok with
> adding these events).

Without seeing actual driver it's impossible to say OK or not.

Post the driver when you're ready and make those two chunks a part of whole
patch.

