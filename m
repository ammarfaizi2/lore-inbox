Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWB0UVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWB0UVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWB0UVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:21:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751091AbWB0UVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:21:18 -0500
Date: Mon, 27 Feb 2006 12:20:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, perex@suse.cz, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
In-Reply-To: <20060227194623.GC9991@suse.de>
Message-ID: <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org>
 <20060227194623.GC9991@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Feb 2006, Greg KH wrote:

> On Mon, Feb 27, 2006 at 02:36:54PM -0500, Benjamin LaHaise wrote:
> > On Mon, Feb 27, 2006 at 11:01:50AM -0800, Greg KH wrote:
> > > --- /dev/null
> > > +++ gregkh-2.6/Documentation/ABI/private/alsa
> > > @@ -0,0 +1,8 @@
> > > +What:		Kernel Sound interface
> > > +Date:		Feburary 2006
> > > +Who:		Jaroslav Kysela <perex@suse.cz>
> > > +Description:
> > > +		The use of the kernel sound interface must be done
> > > +		through the ALSA library.  For more details on this,
> > > +		please see http://www.alsa-project.org/ and contact
> > > +		<alsa-devel@alsa-project.org>
> > 
> > How can something as widely used as sound not work from one kernel version 
> > to the next, as seems to be implied with the "private" nature of the ABI?  
> > This is a total cop-out and is IMHO very amateur of the developers.  If 
> > something like this is to be the case, at the very least the alsa libraries 
> > need to provide a stable ABI and be shipped with the kernel.
> 
> Then I suggest you work with the ALSA developers to come up with such a
> "stable" api that never changes.  They have been working at this for a
> number of years, if it was a "simple" problem, it would have been done
> already...

I really don't much like the "private" and "unstable" subdirectories.

They seem to be just excuses for bad habits. And the notion of a "private" 
interface is insane anyway, since it doesn't matter - the only thing that 
matters is whether it breaks existing binaries or not, and being "private" 
in no way makes any difference to that. If you need to compile or link 
against a new library, it's broken - whether it was "private" or not makes 
no difference.

The ALSA development model is in my opinion pretty broken (the development 
seems to try to be pretty closed-up), but it's (a) gotten better and (b) 
the alsa people do not seem to be breaking old binaries and libraries very 
much. At least I don't remember seeing all that many problems lately.

So I just don't see any upsides to documenting anything private or 
unstable. I see only downsides: it's an excuse to hide behind for 
developers.

		Linus
