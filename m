Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWA0Okf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWA0Okf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWA0Okf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:40:35 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:31392 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751455AbWA0Oke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:40:34 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Out of Memory: Killed process 16498 (java).
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andy Chittenden <AChittenden@bluearc.com>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
In-Reply-To: <20060127142146.GN4311@suse.de>
References: <89E85E0168AD994693B574C80EDB9C2703556694@uk-email.terastack.bluearc.com>
	 <20060127142146.GN4311@suse.de>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 27 Jan 2006 14:39:57 +0000
Message-Id: <1138372797.22112.44.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-01-27 at 15:21 +0100, Jens Axboe wrote:
> On Fri, Jan 27 2006, Andy Chittenden wrote:
> > Any progress on a patch?
> 
> (please don't top post)
> 
> Not yet, sorry, been busy with more critical bugs.

A colleague has a server (which does backups) that is incapable of doing
a backup due to the backup process being killed due to OOM after
anywhere between 30s and a few minutes of running...  And the backup
process is just a simple program that does the equivalent of "dd with
one source but two destinations" where the source is an lvm/dm snapshot
and the two destinations are two different tape drives attached via
scsi.  That is pretty critical, admittedly only to us and that system...

This problem means the system has to sit with an older kernel until such
time as the problem is fixed.

ps. I have no idea if it is the same problem or not but it may well be.
It is a SUSE kernel (SLES9) rather than stock kernel and the problem was
experienced with the 2.6.5-7.202.7 kernel update...  Back to .151 the
system is doing backups just fine, no kernels between .151 and .202.7
have been tried yet on that system and neither has the latest .244
kernel.  We (for a rather all encompassing value of we) pretty much
stopped at .151 due to the e1000 problems in all later kernels although
now we know the magic workaround of disabling TSO people around are
happier to try using more recent kernels (and leaving TSO disabled as
even .244 is badly borked there as soon as you get some traffic load on
any of the e1000s)...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

