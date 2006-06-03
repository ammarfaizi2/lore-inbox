Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWFCI6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWFCI6U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWFCI6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:58:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55730 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932572AbWFCI6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:58:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Bisects that are neither good nor bad
Date: Sat, 3 Jun 2006 10:58:33 +0200
User-Agent: KMail/1.9.3
Cc: Dave Jones <davej@redhat.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060529145255.GB32274@redhat.com> <20060530152926.GA4103@ucw.cz>
In-Reply-To: <20060530152926.GA4103@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031058.33243.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 30 May 2006 17:29, Pavel Machek wrote:
> >  > > I think I've seen the same problem on one of my (similar spec) laptops.
> >  > > Serial console was useless. On resume, there's a short spew of garbage
> >  > > (just like if the baud rate were misconfigured) over serial before it
> >  > > locks up completely.
> >  > 
> >  > <http://bugzilla.kernel.org/show_bug.cgi?id=4270> discusses a similar
> >  > problem on a couple of machines.  In my resume script (for a TP 600X),
> >  > I have to restore the serial console with
> >  > 
> >  >   setserial -a /dev/ttyS0
> >  > 
> >  > Until that magic executes, garbage characters (like modem noise)
> >  > appear across the serial console.
> > 
> > With the resume failure I'm seeing, we don't get back to userspace
> > to run anything like this. It goes bang long before that.
> > 
> > The SATA fix Mark proposed also didn't improve the situation for me :-/
> 
> If setserial -a is needed.. it means that someone really needs to fix
> suspend/resume support for serial... do it on working machine to
> enable debugging of broken ones...
> 
> (But x32 has no serials, so I'm unlikely to code it...)

There's been something wrong with the serial console on the resume front
on my box for quite some time now.  However, I don't use it very often and I
have a patch that disables suspending of the console's serial port, if anyone
is interested (no, I'm not going to post it to the list ;-) ).

I only observed that the serial console works just fine wrt suspend/resume
if I boot with init=/bin/bash.

Greetings,
Rafael
