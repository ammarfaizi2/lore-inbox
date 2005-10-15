Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVJOIRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVJOIRF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 04:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVJOIRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 04:17:04 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:64947 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750964AbVJOIRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 04:17:04 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 15 Oct 2005 09:16:54 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
In-Reply-To: <2cd57c900510150056j2a6af6e5gf93ce9fa4ef16aac@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510150909050.25927@hermes-1.csi.cam.ac.uk>
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe>
  <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
 <2cd57c900510150056j2a6af6e5gf93ce9fa4ef16aac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2005, Coywolf Qi Hunt wrote:
> On 10/15/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Fri, 14 Oct 2005, Lee Revell wrote:
> > > On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
> > > > Is there any way to force an immediate reboot as if to push the reset
> > > > button in software? Got a remote server that i need to reboot and
> > > > shutdown isn't working.
> > >
> > > If it has Oopsed, and the "reboot" command does not work, then all bets
> > > are off - kernel memory has probably been corrupted.
> > >
> > > Get one of those powerstrips that you can telnet into and power cycle
> > > things remotely.
> >
> > If it has sysrq compiled in as root just do:
> >
> > echo s > /proc/sysrq-trigger
> > echo u > /proc/sysre-trigger
> > echo s > /proc/sysrq-trigger
> 
> What the purpose of the second sync?

Allows any i/o initiated between the first sync and the remount r/o to 
complete.  Remember that r/o mounting doesn't stop i/o.  It only stops you 
from writing to the fs at the vfs layer.  Once a write/modification has 
entered the fs driver it will get written no matter what, unless the 
"reboot" sysrq is triggered in which case the kernel just reboots 
immediately.

Maybe it is just paranoia on my part but I have gotten used to hitting 
Alt+PrtScr+S, +U, +S, +B so I do it automatically.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
