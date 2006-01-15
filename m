Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWAOIfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWAOIfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWAOIfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 03:35:23 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:9361 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751865AbWAOIfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 03:35:23 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sun, 15 Jan 2006 08:35:10 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Dave Jones <davej@redhat.com>
cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
In-Reply-To: <20060115070658.GB6454@redhat.com>
Message-ID: <Pine.LNX.4.64.0601150831220.29779@hermes-2.csi.cam.ac.uk>
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de>
 <20060114225137.GB23021@redhat.com> <200601150105.08197.ak@suse.de>
 <20060115070658.GB6454@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, Dave Jones wrote:
> On Sun, Jan 15, 2006 at 01:05:07AM +0100, Andi Kleen wrote:
>  > On Saturday 14 January 2006 23:51, Dave Jones wrote:
>  > > On Sat, Jan 14, 2006 at 07:43:27PM +0100, Andi Kleen wrote:
>  > >  > On Saturday 14 January 2006 07:52, Dave Jones wrote:
>  > >  > > Andi,
>  > >  > >  Sometime in the last week something was introduced to Linus'
>  > >  > > tree which makes my dual EM64T go nuts when X tries to start.
>  > >  > > By "go nuts", I mean it does various random things, seen so
>  > >  > > far..
>  > >  > > - Machine check. (I'm convinced this isn't a hardware problem
>  > >  > >   despite the new addition telling me otherwise :)
>  > >  >
>  > >  > Normally it should be impossible to cause machine checks from software
>  > >  > on Intel systems.
>  > >
>  > > -git7+ is the only time I've ever seen one on this box.
>  > 
>  > What happens when you apply
>  > 
>  > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/page-table-setup
> 
> What does this apply to ? Is it dependant on something else not
> merged yet ? I get rejects when I apply it to 2.6.15-git10
> 
> I don't have time to fix it up by hand right now (I was going to set
> a build going before I turned in for the night..)
> 
> I'll poke at it again tomorrow.
> 
> Another datapoint btw: I've another EM64T that works just fine.
> The one that fails is the only one that isn't using onboard VGA,
> this one has a PCIE Radeon.  Given it happens when X is starting up,
> it could be that the X radeon driver does something special which
> is why others aren't seeing this.

On my i386 box with an ati radeon 9600 agp card of sorts trying to use the 
radeon driver (ever since I installed suse 10.0) causes an immediate hard 
lockup on startup of X.  Sounds like your problem...  Setting the driver 
to VESA or using the ati proprietory driver works fine (but only the ati 
driver actually is usable for me).

You could try that and if the others work for you like for me then it is 
likely the problem is indeed 100% in the radeon driver somewhere...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
