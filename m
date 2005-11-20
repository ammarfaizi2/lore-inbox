Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVKTPeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVKTPeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 10:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVKTPeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 10:34:44 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:38556 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751247AbVKTPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 10:34:43 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sun, 20 Nov 2005 15:34:28 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
In-Reply-To: <84144f020511190247n5cf17800lb4ff019aa406470@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0511201531010.20876@hermes-1.csi.cam.ac.uk>
References: <20051119041130.GA15559@sshock.rn.byu.edu> 
 <20051119041740.GD15747@sshock.rn.byu.edu> <84144f020511190247n5cf17800lb4ff019aa406470@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2005, Pekka Enberg wrote:
> On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > +                       BUG();
> > +                       err = -EINVAL;
> > +                       goto out;
> 
> Why do you want to BUG() and then handle the situation?

Because you can define BUG() to nothing (on embedded builds for example) 
and then you would be screwed if you don't handle the error gracefully.  
You should never assume something does not return, except perhaps a 
panic() although someone might even get rid of that one day...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
