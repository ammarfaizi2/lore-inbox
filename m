Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWB0TqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWB0TqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0TqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:46:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:5772 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751461AbWB0TqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:46:21 -0500
Date: Mon, 27 Feb 2006 11:46:23 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227194623.GC9991@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227193654.GA12788@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 02:36:54PM -0500, Benjamin LaHaise wrote:
> On Mon, Feb 27, 2006 at 11:01:50AM -0800, Greg KH wrote:
> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/private/alsa
> > @@ -0,0 +1,8 @@
> > +What:		Kernel Sound interface
> > +Date:		Feburary 2006
> > +Who:		Jaroslav Kysela <perex@suse.cz>
> > +Description:
> > +		The use of the kernel sound interface must be done
> > +		through the ALSA library.  For more details on this,
> > +		please see http://www.alsa-project.org/ and contact
> > +		<alsa-devel@alsa-project.org>
> 
> How can something as widely used as sound not work from one kernel version 
> to the next, as seems to be implied with the "private" nature of the ABI?  
> This is a total cop-out and is IMHO very amateur of the developers.  If 
> something like this is to be the case, at the very least the alsa libraries 
> need to provide a stable ABI and be shipped with the kernel.

Then I suggest you work with the ALSA developers to come up with such a
"stable" api that never changes.  They have been working at this for a
number of years, if it was a "simple" problem, it would have been done
already...

Anyway, netlink is in the same category, with a backing userspace
library tie :)

And, I have nothing against shipping userspace libraries with the kernel
like this, if people think that's the easiest way to do it.  But even
then, the raw interface is still "private" and you need to use the
library to access it properly.

thanks,

greg k-h
