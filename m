Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUEENi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUEENi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbUEENi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:38:28 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:29877 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264663AbUEENiZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:38:25 -0400
Subject: Re: [BUG] 2.6.5 ntfs
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <mg@iceni.pl>
Cc: ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200405051432.20036.mg@iceni.pl>
References: <200405031407.46408.m.gibula@conecto.pl>
	 <200405041957.38185.m.gibula@conecto.pl>
	 <1083758242.916.42.camel@imp.csi.cam.ac.uk>
	 <200405051432.20036.mg@iceni.pl>
Content-Type: text/plain; charset=iso-8859-2
Organization: University of Cambridge Computing Service
Message-Id: <1083764166.916.68.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 14:36:07 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 13:32, Marcin Gibu³a wrote:
> > not be zero any more.  Have you ever run memtest on your machine?
> 
> I'll try to do this.
> 
> > If you run "chkdsk /f" from windows on this partition, does it detect
> > any errors?
> 
> It doesn't.

Ok.

> > dd if=~/mymftdump of=~/inode0x78a bs=1024 count=1 skip=1930
> >
> > And then email me the file ~/inode0x78a (this is only 1kiB in size).
> 
> Here it goes.

Thanks.  Analyzing this it is a highly fragmented file so it the $DATA
attribute is spread over three more inodes.  Could you email them to me,
too please?  They are 0x790 (= 1936), 0x791 (= 1937), and 0x792 (1938).

You can get them like this (assuming you are using Bash as your shell):

for i in 1936 1937 1938; do
	dd if=~/mymftdump of=~/inode$i bs=1024 count=1 skip=$i
done

Once I have those I can uncompress the mapping pairs arrays in the data
extents and ask you to capture the compressed data for me.  It will be a
simple script simillar to the above...

Thanks a lot for your help.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


