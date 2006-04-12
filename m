Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWDLXba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWDLXba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWDLXba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:31:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:12435 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932411AbWDLXb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:31:29 -0400
Date: Wed, 12 Apr 2006 16:30:32 -0700
From: Greg KH <gregkh@suse.de>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is platform_device_register_simple() deprecated?
Message-ID: <20060412233032.GA28007@suse.de>
References: <443D3DED.5030009@keyaccess.nl> <20060412214108.GA12480@suse.de> <7724966D-F760-4075-8D69-B4B73700A9BA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7724966D-F760-4075-8D69-B4B73700A9BA@kernel.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 06:09:48PM -0500, Kumar Gala wrote:
> 
> On Apr 12, 2006, at 4:41 PM, Greg KH wrote:
> 
> >On Wed, Apr 12, 2006 at 07:50:37PM +0200, Rene Herman wrote:
> >>Hi Greg, Russel, Dmitry.
> >>
> >>ALSA is using platform_device_register_simple(). Jean Delvare  
> >>pointed:
> >>
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2
> >>
> >>out, where _simple looks to be slated for removal. Is this indeed the
> >>case? ALSA isn't using the resources -- doing a manual alloc/add  
> >>would
> >>not be a problem...
> >
> >Great, care to convert ALSA to use the proper api so we can remove
> >platform_device_register_simple()?
> 
> Can we mark this deprecated and add it to feature-removal-schedule.txt.

Sure, I'll take a patch for that.  But really, it's just easier to fix
up all callers and delete the function.  It isn't anything that
feature-removal-schedule.txt should care about, as it's just the normal
API changes we do all the time.

thanks,

greg k-h
