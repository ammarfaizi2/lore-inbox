Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVJaUFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVJaUFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVJaUFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:05:40 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:29102 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964809AbVJaUFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:05:40 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 20:05:34 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Yuval <yuvalfl@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] [2.6-GIT] NTFS: Release 2.1.25.
In-Reply-To: <71e16e3c0510311130v1d924733qeff864bb9ada93b4@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510312000450.10190@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
 <71e16e3c0510311130v1d924733qeff864bb9ada93b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Yuval wrote:
> On 10/31/05, Anton Altaparmakov wrote:
> > What this means is that you can now run your favourite editor on an
> > existing file, e.g. "vim /ntfs/somefile.txt" works fine and you can save
> > your changes.  Also things like running OpenOffice and editing existing MS
> > Office documents works.  Basically anything that does not need to create
> > temporary files in the same directory as the document should work fine
> > now.
> 
> How is possible to use a text editor? Aren't most of them use a temporary file?
> I spent some time ago documenting it in
> http://wiki.linux-ntfs.org/doku.php?id=texteditorpitfall after it came
> up on the linux-ntfs-dev mailing list (long ago). Am I wrong?
> 
> I remember Rich writing about some command of vim to disable the
> temporary file feature, but you haven't mentioned that one, so I
> assume it works for you "out-of-the-box".

It does work out of the box when I tried it without any visible errors or 
warnings from vim.  I assume it either creates a temporary file in /tmp or 
the file I was editing was small enough that it could just cache it in 
memory or whatever.  I don't know what it did, just that it worked fine.

Note that before one of the reasons it was failing was that vim would try 
to truncate the file and then write it again and truncate was not 
supported.  It is supported now so it works.

Certainly normally "vim somefile" creates the file ".somefile.swp" which 
it clearly cannot do in this case but obviously it can cope with this.

Perhaps it depends on which editor/version/compile settings maybe even you 
have...

All I can say is that both vim and OpenOffice Writer worked fine when I 
tried them on SUSE Linux 9.3.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
