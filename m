Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVHEStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVHEStu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVHESsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:48:02 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:833 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263100AbVHESrZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:47:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afCvsoW40OQBAyhswEm4gb2Y0ndrHozUylmYgcqliO392oOPeWnRCniyXFChXPk0FZ8U6Z2oGz7j7vB+z15+enwfiyVymW9EZ3B8cUYOjccJGzEZ/nCDITBRTxycVXbHS38meD2Eyr4qMh9wOddpsgDr+PyHo+t8dfl5aXDjL1s=
Message-ID: <9e47339105080511474d89ee8a@mail.gmail.com>
Date: Fri, 5 Aug 2005 14:47:18 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200508052020.13568.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726015401.GA25015@kroah.com>
	 <200508052001.11442.oliver@neukum.org>
	 <9e47339105080511143e01c531@mail.gmail.com>
	 <200508052020.13568.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag, 5. August 2005 20:14 schrieb Jon Smirl:
> > On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> > > Am Freitag, 5. August 2005 15:32 schrieb Jon Smirl:
> > > > On 1/1/02, Pavel Machek <pavel@ucw.cz> wrote:
> > > > > Hi!
> > > > >
> > > > > > > > New, simplified version of the sysfs whitespace strip patch...
> > > > > > >
> > > > > > > Could you tell me why you don't just fail the operation if malformed
> > > > > > > input is supplied?
> > > > > >
> > > > > > Leading/trailing white space should be allowed. For example echo
> > > > > > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > > > > > than to teach everyone to use -n.
> > > > >
> > > > > Please, NO! echo -n is the right thing to do, and users will eventually learn.
> > > > > We are not going to add such workarounds all over the kernel...
> > > >
> > > > It is not a work around. These are text attributes meant for human
> > > > use.  Humans have a hard time cleaning up things they can't see. And
> > > > the failure mode for this is awful, your attribute won't set but
> > > > everything on the screen looks fine.
> > >
> > > The average user has no place poking sysfs. Root should know when
> > > to use -n, as should shell scripts.
> >
> > So the average user never needs to change their console mode? Check
> > out /sys/class/graphics/fb/modes and mode.
> 
> That is what we have helper scripts for.

If we are going back to needing helper scripts then I should just
remove the entire sysfs graphics interface and switch back to using
ioctls and a helper app. Of could no one can ever find the helper app
or remember how it works. I thought one of the main reasons behind the
sysfs interface was to eliminate these helper apps.

Without doing whitespace cleanup there is a 100% probability that this
will generate bug reports. I know this for a fact because I am already
getting them.

-- 
Jon Smirl
jonsmirl@gmail.com
