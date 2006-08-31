Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWHaATD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWHaATD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 20:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHaATC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 20:19:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:27840 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932255AbWHaATA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 20:19:00 -0400
Date: Wed, 30 Aug 2006 17:17:42 -0700
From: Greg KH <greg@kroah.com>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060831001742.GB26265@kroah.com>
References: <20060830062338.GA10285@kroah.com> <44F5C5E0.4050201@gmail.com> <20060830175250.GA6258@kroah.com> <44F6164F.6000709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F6164F.6000709@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 02:50:55AM +0400, Manu Abraham wrote:
> Greg KH wrote:
> > On Wed, Aug 30, 2006 at 09:07:44PM +0400, Manu Abraham wrote:
> >> Being a bit excited and it is really interesting to have such a
> >> proposal, it would simplify the matters that held us up even more,
> >> probably. The name sounds fine though. All i was wondering whether there
> >> would be any high latencies for the same using in such a context. But
> >> since the transfers would occur in any way, even with a kernel mode
> >> driver, i think it should be pretty much fine.
> > 
> > As mentioned, this framework is being used in industrial settings right
> > now, where latencies are a huge issue.  It works just fine, so I do not
> > think there are any problems in this area.
> 
> Cool.
> 
> Is there some way we can avoid the poll ? It would be a real gain
> indeed, if a POLL can be avoided.

Use the signal that will be sent to your userspace program when an
interrupt happens.

If you can handle the small latency that causes it should be fine, but
if you can't, then you should be using poll :)

It all depends on the hardware you are using, your processor, and what
your tolerances are on your interrupt handling latency.

thanks,

greg k-h
