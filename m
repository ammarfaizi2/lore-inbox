Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTDPSp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTDPSp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:45:29 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:12037 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264533AbTDPSp1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:45:27 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: How to identify contents of /lib/modules/*
Date: Wed, 16 Apr 2003 13:57:15 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E1064045133AC@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to identify contents of /lib/modules/*
Thread-Index: AcMEPKr8LSP9lD9yT1qSBuiA3TLf7AABj62w
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <Paul.Clements@steeleye.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Apr 2003 18:57:16.0155 (UTC) FILETIME=[FF75F4B0:01C30449]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul.Clements@steeleye.com wrote:

> The truth is, the kernel rpms for this distro are not designed to be 
> installed side by side, they really ought to be upgraded (meaning the 
> old stuff gets removed, so there's no ambiguity). Do you actually 
> have customers that are installing multiple kernels and moving /lib/modules 
> dirs around? (I know we do this in our labs, and you may too, but I 
> can't imagine too many customers doing this...)

Yes, the RPMs in question overwrite the currently used kernel.... 
(then of course, the user is rather amazed and disgusted at the 
nerve of this RPM.   The next time he has such an RPM to install 
he remembers this event, and saves off his old kernel and 
/lib/modules directory before the RPM can destroy it.)

> > Also note, I can't just figure out which is the _running_ kernel  [...]
? Hmm... I'm not sure how feasible that's going to be... 

The problem case here is this one:

1) You have a brand new machine, with a brand new disk controller.
You install the OS, use a driver diskette for the brand new
disk controller.  The driver diskette is made for the default
kernel installed by the base media.  

2) You install a new errata kernel (because let's suppose the one on the CD
has known security problems, or something.)  However, you cannot 
reboot yet because the new errata kernel does not contain a driver which 
understands your new controller.

3) Install RPM driver for the new controller.  The RPM cannot rely on 
the running kernel, because you don't care about the running kernel,
you care about the errata kernel that you just installed, but which is
not yet running.

So feasible or no, we must try.  (Anyway, I think I have something
that will work, it's just kinda ugly, is all, and I was hoping
there was a beter way.)

> Is there any chance that SuSE (oops, let the cat out of the bag ;) 

I never said SuSE.  (Excellent guess though. :-)

> would accept your driver(s) into their distribution, or

Yes, that's no problem.  But it's always too late.
There will always be the case that we must support old
kernels that were deployed before the hardware that we're
trying to support.  And by "support" I also mean that
some level of testing has occurred, so this isn't possible.

Thanks for your thoughts on the matter.

-- steve
