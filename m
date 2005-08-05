Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVHESe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVHESe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVHESbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:31:52 -0400
Received: from mail1.kontent.de ([81.88.34.36]:58345 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262807AbVHESaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:30:24 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Fri, 5 Aug 2005 20:20:11 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
References: <20050726015401.GA25015@kroah.com> <200508052001.11442.oliver@neukum.org> <9e47339105080511143e01c531@mail.gmail.com>
In-Reply-To: <9e47339105080511143e01c531@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508052020.13568.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 5. August 2005 20:14 schrieb Jon Smirl:
> On 8/5/05, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Freitag, 5. August 2005 15:32 schrieb Jon Smirl:
> > > On 1/1/02, Pavel Machek <pavel@ucw.cz> wrote:
> > > > Hi!
> > > >
> > > > > > > New, simplified version of the sysfs whitespace strip patch...
> > > > > >
> > > > > > Could you tell me why you don't just fail the operation if malformed
> > > > > > input is supplied?
> > > > >
> > > > > Leading/trailing white space should be allowed. For example echo
> > > > > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > > > > than to teach everyone to use -n.
> > > >
> > > > Please, NO! echo -n is the right thing to do, and users will eventually learn.
> > > > We are not going to add such workarounds all over the kernel...
> > >
> > > It is not a work around. These are text attributes meant for human
> > > use.  Humans have a hard time cleaning up things they can't see. And
> > > the failure mode for this is awful, your attribute won't set but
> > > everything on the screen looks fine.
> > 
> > The average user has no place poking sysfs. Root should know when
> > to use -n, as should shell scripts.
> 
> So the average user never needs to change their console mode? Check
> out /sys/class/graphics/fb/modes and mode.

That is what we have helper scripts for.

	Regards
		Oliver

