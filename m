Return-Path: <linux-kernel-owner+w=401wt.eu-S1753278AbWLOTa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbWLOTa1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 14:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbWLOTa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 14:30:26 -0500
Received: from pat.uio.no ([129.240.10.15]:48439 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278AbWLOTa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 14:30:26 -0500
Subject: Re: [2.6.19] NFS: server error: fileid changed
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <801847.80879.qm@web32613.mail.mud.yahoo.com>
References: <801847.80879.qm@web32613.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 14:30:14 -0500
Message-Id: <1166211014.5761.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 09:16 -0800, Martin Knoblauch wrote:
> --- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > 
> > >  Is there a  way to find out which files are involved? Nothing
> > seems to
> > > be obviously breaking, but I do not like to get my logfiles filled
> > up. 
> > 
> > The fileid is the same as the inode number. Just convert those
> > hexadecimal values into ordinary numbers, then search for them using
> > 'ls
> > -i'.
> > 
> > Trond
> > 
> > > [ 9337.747546] NFS: server nvgm022 error: fileid changed
> > > [ 9337.747549] fsid 0:25: expected fileid 0x7a6f3d, got 0x65be80
> Hi Trond, 
> 
>  just curious: how is the fsid related to mounted filesystems? What
> does "0:25" stand for?
> 

In this case the fsid is just the major:minor device numbers assigned to
that filesystem.
Look for it using 'stat -printf "%D\n" /mountpoint' 

Cheers
  Trond

