Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUKTLAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUKTLAc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 06:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUKTLAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:00:32 -0500
Received: from dp.samba.org ([66.70.73.150]:60619 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261654AbUKTLA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:00:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.8212.96811.520317@samba.org>
Date: Sat, 20 Nov 2004 21:44:36 +1100
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <Pine.LNX.4.60.0411191352050.8634@hermes-1.csi.cam.ac.uk>
References: <16797.41728.984065.479474@samba.org>
	<1100865833.6443.17.camel@imp.csi.cam.ac.uk>
	<16797.60034.186288.663343@samba.org>
	<Pine.LNX.4.60.0411191352050.8634@hermes-1.csi.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton,

 > But to answer your question I definitely would envisage an interface to 
 > the kernel driver rather than to libntfs.  It is 'just' a matter of 
 > deciding how that would look...

How about prototyping the API in user space, using a "mmap the block
device" based filesystem library?

You might also like to take a peek at
  http://samba.org/ftp/unpacked/samba4/source/include/smb_interfaces.h
and 
  http://samba.org/ftp/unpacked/samba4/source/ntvfs/ntvfs.h

those two files define the NTFS-like interfaces in Samba4. The
interface has proved to be quite flexible.

 > Partially we will see what happens with Reiser4 as it faces the same or at 
 > least very simillar interface problems.

yep, I'm looking forward to experimenting with the "file is a
directory" stuff in reiser4 to see how well it can be made to match
what is needed for Samba4. 

Cheers, Tridge
