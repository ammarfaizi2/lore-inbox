Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270823AbRH1MbQ>; Tue, 28 Aug 2001 08:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRH1MbH>; Tue, 28 Aug 2001 08:31:07 -0400
Received: from ns1ca.ubisoft.qc.ca ([205.205.27.131]:7951 "EHLO
	ns1ca.ubisoft.qc.ca") by vger.kernel.org with ESMTP
	id <S270847AbRH1May>; Tue, 28 Aug 2001 08:30:54 -0400
Message-ID: <9A1957CB9FC45A4FA6F35961093ABB8404220586@srvmail-mtl.ubisoft.qc.ca>
From: Patrick Allaire <pallaire@gameloft.com>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: How to disable blanking of the screen in the kernel ?
Date: Tue, 28 Aug 2001 08:24:54 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you that what I was looking for ... I dont want to add 20k for the
setterm app.

Patrick Allaire
mailto:pallaire@gameloft.com
If you can see it, but it's not there, it's virtual. 
If you can't see it, but it is there, it's hidden. 
It you can't see it and it isn't there, it's gone.



> -----Original Message-----
> From: Robert Love [mailto:rml@tech9.net]
> Sent: August 27, 2001 5:14 PM
> To: Patrick Allaire
> Cc: Linux Kernel List
> Subject: Re: How to disable blanking of the screen in the kernel ?
> 
> 
> On Mon, 2001-08-27 at 16:50, Patrick Allaire wrote:
> > I am on a 2.2.19 kernel. I am doing an embedded box and I 
> want to disable
> > the console blanking ... how can I do that ? I dont have 
> apm support in the
> > kernel. there is no X on the box ...
> 
> the userspace solution is simply `setterm -blank 0'
> 
> if you dont want setterm, I wager it just uses an ioctl to set the
> appropriate option.
> 
> if you want to disable it permanently, take a look around
> drivers/char/console.c
> 
> there is a
> static int blankinterval = 10*60*HZ;
> setting that to 0 should do the job.  you could take it 
> further and rip
> out some of the *blank* functions that you wont be needing, 
> to make your
> kernel smaller.
> 
> -- 
> Robert M. Love
> rml at ufl.edu
> rml at tech9.net
> 
