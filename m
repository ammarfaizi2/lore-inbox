Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWJKXNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWJKXNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWJKXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:13:31 -0400
Received: from mx1.suse.de ([195.135.220.2]:53660 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161265AbWJKXNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:13:30 -0400
Date: Wed, 11 Oct 2006 16:13:19 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Early keyboard initialization?
Message-ID: <20061011231319.GC28589@suse.de>
References: <20061006204254.GD5489@bouh.residence.ens-lyon.fr> <200610072158.55659.dtor@insightbb.com> <20061011130832.c9e9b4d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011130832.c9e9b4d5.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 01:08:32PM -0700, Andrew Morton wrote:
> On Sat, 7 Oct 2006 21:58:54 -0400
> Dmitry Torokhov <dtor@insightbb.com> wrote:
> 
> > On Friday 06 October 2006 16:42, Samuel Thibault wrote:
> > > Hi,
> > > 
> > > Is there any reason for initializing the input layer and keyboards so
> > > late?  Since prevents from being able to perform alt-sysrqs early, and
> > > blind people who use speakup would like to get early control over the
> > > speech.  Here is the patch that they use.
> > >
> 
> It'd be nice to get sysrq working as early as poss.
> 
> > It looks like the change will only work for non-USB input devices since
> > USB subsystem is initialized much later.
> 
> USB is usually modular (isn't it?)
> 
> > Greg, is there a reason why USB can't be initialized earlier?
> 
> Greg's in hiding.

Yeah, under this huge pile of "real work" stuff that I have right now,
sorry about the delay...

It would be fine to get USB working earlier, but we need PCI, and pretty
much everything else up and working first in order for it to be there,
so I don't know how well it would work out.

And yes, it is annoying about how some machines you are locked out of
keyboard support for a long time, I don't know what to really do about
it.

Feel free to mess with the linking order if you want to try to reduce
the delay and see how it works out.

thanks,

greg k-h
