Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVGDPMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVGDPMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 11:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVGDPMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 11:12:19 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:11907 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261218AbVGDPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:12:12 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Problem with inotify
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: David =?ISO-8859-1?Q?G=F3mez?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1120487948.11399.7.camel@imp.csi.cam.ac.uk>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
	 <20050630193320.GA1136@fargo>
	 <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>
	 <20050630204832.GA3854@fargo>
	 <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>
	 <42C65A8B.9060705@gentoo.org>
	 <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>
	 <42C72563.7040103@gentoo.org>
	 <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>
	 <42C7BF37.9010005@gentoo.org>  <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
	 <1120487948.11399.7.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 04 Jul 2005 16:12:02 +0100
Message-Id: <1120489922.11399.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-04 at 15:39 +0100, Anton Altaparmakov wrote:
> On Mon, 2005-07-04 at 15:27 +0100, Anton Altaparmakov wrote:
> > On Sun, 2005-07-03 at 11:34 +0100, Daniel Drake wrote:
> > > I reverted the patch you sent earlier
> > > (inotify_unmount_inodes-list-iteration-fix.diff) and applied the one you
> > > attached here (inotify_unmount_inodes-list-iteration-fix2.diff).
> > > 
> > > The good news is that the hang is gone. The bad news is that you cured the
> > > hang by introducing an oops :(
> > 
> > )-:  I have addressed the only things I can think off that could cause
> > the oops and below is the resulting patch.  Could you please test it?
> 
> I forgot to say that this patch is a replacement for the previous
> (inotify_unmount_inodes-list-iteration-fix{,2}.diff}.

Note I seem to remember you are using 2.6.12?  If so I am not sure when
the I_WILL_FREE stuff came into existence, so should inotify.c not
compile after applying this patch just delete the " | I_WILL_FREE " in
the two places it occurs introduced by the patch and all should be fine.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

