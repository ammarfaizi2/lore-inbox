Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbSIXVlh>; Tue, 24 Sep 2002 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSIXVlh>; Tue, 24 Sep 2002 17:41:37 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:62892 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261830AbSIXVlf>; Tue, 24 Sep 2002 17:41:35 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0A5389D8@orsmsx108.jf.intel.com>
From: "Rhoads, Rob" <rob.rhoads@intel.com>
To: "'Greg KH'" <greg@kroah.com>, "Rhoads, Rob" <rob.rhoads@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE] Linux Hardened Device Drivers Project
Date: Tue, 24 Sep 2002 14:46:35 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH [mailto:greg@kroah.com]
> 
[snip]
> 
> > An underlying theme tends to revolve around the binding
> > of the concepts of 'hardening' and RAS features being 
> > added to drivers.  We will be looking into splitting 
> > these two different approaches out from this singular 
> > document and into their appropriate locations.
> 
> Where would these locations be?
> 

First throw away any idea of a spec. That was a bad idea. :)

Next, turn the first section, "Stability & Reliability" of our 
original doc into a "Driver Hardening HOWTO". It would be a 
list of characteristics that all good drivers should have, 
packed with examples to back it up. 

BTW, by no means did I or anyone involved on this project, ever 
mean to imply that the current drivers in the kernel are "bad". 
Rather, I'd like to capture a list of the best practices and 
document them. In any event our current list needs to be 
strengthened with concrete examples. My thinking is that we 
should work with the Kernel Janitor project. This is where 
Intel can probably really help out.

The section on Instrumentation should be broken up and each piece 
dealt with separately as separate project. Most likely killed outright 
or as part of existing efforts. I see this section as not having
anything to do with driver hardening and more to do with driver RAS.

POSIX Event Logging-- is a dead issue. The mailing list feedback 
is making that point very clear, many thanks. The current
thread on an alternative, seems like there is some sort of need
for event logging. Whatever the final decision that the Linux 
community decides, we'll do.

There seems to be a desire to have some sort of driver diagnostics.
We can work on that with the existing linux-diag project.

Statistics needs to be debated on its own merits. There are some 
arguments for keeping it, but I think that stats could be better 
handled in user-space and NOT kernel space. IMHO it's not driver 
hardening, therefore it's a separate project. 

Third, the most of the section on High Availability should just 
be axed. The big exception being "fault injection testing". 

I see value in keeping FI testing. I think that getting FI 
tools into the hands of developers would be worthwhile. Why? 
Because letting people do more complicated testing, produces 
better code. I think there is room for us to work on a set of 
FI tools.

> > If you are interested (even if you aren't) please go 
> > to http://lists.sourceforge.net/lists/listinfo/hardeneddrivers-discuss 
> and subscribe to the mailing list.
>
> Sorry, but major kernel driver discussions should occur on lkml.
> 
> thanks,
> 
> greg k-h

