Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbVHEUSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbVHEUSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVHEUSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:18:38 -0400
Received: from mail1.kontent.de ([81.88.34.36]:2960 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263120AbVHEUSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:18:00 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Fri, 5 Aug 2005 22:07:49 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
References: <20050726015401.GA25015@kroah.com> <200508052020.13568.oliver@neukum.org> <9e47339105080511474d89ee8a@mail.gmail.com>
In-Reply-To: <9e47339105080511474d89ee8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508052207.49270.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. August 2005 20:47 schrieb Jon Smirl:
> On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Freitag, 5. August 2005 20:14 schrieb Jon Smirl:
> > > On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> > > > Am Freitag, 5. August 2005 15:32 schrieb Jon Smirl:
> > > > > On 1/1/02, Pavel Machek <pavel@ucw.cz> wrote:
> > > > > > Hi!
> > > > > >
> > > > > > > > > New, simplified version of the sysfs whitespace strip patch...
> > > > > > > >
> > > > > > > > Could you tell me why you don't just fail the operation if malformed
> > > > > > > > input is supplied?
> > > > > > >
> > > > > > > Leading/trailing white space should be allowed. For example echo
> > > > > > > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > > > > > > than to teach everyone to use -n.
> > > > > >
> > > > > > Please, NO! echo -n is the right thing to do, and users will eventually learn.
> > > > > > We are not going to add such workarounds all over the kernel...
> > > > >
> > > > > It is not a work around. These are text attributes meant for human
> > > > > use.  Humans have a hard time cleaning up things they can't see. And
> > > > > the failure mode for this is awful, your attribute won't set but
> > > > > everything on the screen looks fine.
> > > >
> > > > The average user has no place poking sysfs. Root should know when
> > > > to use -n, as should shell scripts.
> > >
> > > So the average user never needs to change their console mode? Check
> > > out /sys/class/graphics/fb/modes and mode.
> > 
> > That is what we have helper scripts for.
> 
> If we are going back to needing helper scripts then I should just
> remove the entire sysfs graphics interface and switch back to using
> ioctls and a helper app. Of could no one can ever find the helper app
> or remember how it works. I thought one of the main reasons behind the
> sysfs interface was to eliminate these helper apps.

The point is that you _can_ do it with echo, not that it is _easy_.
Nor is sysfs a solution in any case.

> Without doing whitespace cleanup there is a 100% probability that this
> will generate bug reports. I know this for a fact because I am already
> getting them.

Stupid users are not a reason for kernel bloat.

	Regards
		Oliver
