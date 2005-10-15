Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVJOHsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVJOHsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVJOHsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:48:17 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:33678 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751119AbVJOHsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:48:16 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sat, 15 Oct 2005 08:48:12 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Forcing an immediate reboot
In-Reply-To: <1129341050.23895.12.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0510150846430.25927@hermes-1.csi.cam.ac.uk>
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005, Lee Revell wrote:
> On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
> > Is there any way to force an immediate reboot as if to push the reset 
> > button in software? Got a remote server that i need to reboot and 
> > shutdown isn't working.
> 
> If it has Oopsed, and the "reboot" command does not work, then all bets
> are off - kernel memory has probably been corrupted.
> 
> Get one of those powerstrips that you can telnet into and power cycle
> things remotely.

If it has sysrq compiled in as root just do:

echo s > /proc/sysrq-trigger
echo u > /proc/sysre-trigger
echo s > /proc/sysrq-trigger
echo b > /proc/sysrq-trigger

This will "sync", "umount/remount read-only", "sync", "immediate hardware 
reboot".  Should always work...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
