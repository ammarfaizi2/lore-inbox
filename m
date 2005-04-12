Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVDLBXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVDLBXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVDLBXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:23:42 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:60519 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262000AbVDLBWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:22:00 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Rob Landley <rob@landley.net>
Subject: Re: Policy question (was Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop)
Date: Mon, 11 Apr 2005 21:21:51 -0400
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <20050406212221.75716.qmail@web88010.mail.re2.yahoo.com> <200504112009.30928.rob@landley.net>
In-Reply-To: <200504112009.30928.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504112121.52203.shawn.starr@rogers.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, of course. When I get around to figuring out the best way to do this.  
Since I don't want to bloat up sysfs ACPI stuff just to check if the echoed 
value is a number or string. We can just gradually phase it out by just 
marking it DEPRECATED and keep it ON in the Kbuild file so nobody looses the 
functionality until then.

I'm thinking 2 years but some say thats too long :)

Now that I look at it, I don't need to put it into a CONFIG option as its 
already a module :-) even better.

Shawn.

On April 11, 2005 20:09, Rob Landley wrote:
> On Wednesday 06 April 2005 05:22 pm, Shawn Starr wrote:
> > --- Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > > > So nobody minds if I make this into a CONFIG
> > >
> > > option marked as Deprecated? :)
> > >
> > > Actually it should probably go through
> > >
> > > Documentation/feature-removal-schedule.txt
> > >
> > > ...and give it *long* timeout, since it is API
> > > change.
> > >          Pavel
>
> Shouldn't all deprecated features be in feature-removal-schedule.txt?
>
> There are four entries in feature-removal-schedule in 2.6.12-rc2, but
> `find . -name "Kconfig" | xargs grep -i deprecated` finds eight entries. 
> (And there's more if the grep -i is for "obsolete" instead...)
>
> Just wondering...
>
> Rob
