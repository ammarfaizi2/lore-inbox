Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263559AbTDIQln (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTDIQln (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:41:43 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:24963 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S263559AbTDIQlm (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 12:41:42 -0400
Message-Id: <200304091653.h39GrHR05341@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Joel Becker <Joel.Becker@oracle.com>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ? 
In-Reply-To: Message from Joel Becker <Joel.Becker@oracle.com> 
   of "Wed, 09 Apr 2003 08:48:36 PDT." <20030409154836.GA31739@ca-server1.us.oracle.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 09 Apr 2003 18:53:17 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joel Becker wrote:
> On Wed, Apr 09, 2003 at 02:16:08PM +0200, Rob van Nieuwkerk wrote:
> > I plan to use O_DIRECT in my application (on a partition, no fs).
> > It is hard to find info on the exact requirements on the mandatory
> > alignments of buffer, offset, transfer size: it's easy to find many
> > contradicting documents.  And checking the kernel source itself isn't
> > trivial.
> 
> 	In 2.4, your buffer, offset, and transfer size must be soft
> blocksize aligned.  That's the output of BLKBSZGET against the block
> device.  For unmounted partitions that is 512b, for most people's ext3
> filesystems that is 4K.  It is, FYI, the number set by set_blocksize().

Hi Joel,

Thank you for your reaction.

I get 4096 with BLKBSZGET on several unmounted partitions on my system
(RH 2.4.18-27.7.x kernel).  Some give 1024 ..  Maybe it is because I
had them mounted first and unmounted them for the test ?

	greetings,
	Rob van Nieuwkerk
