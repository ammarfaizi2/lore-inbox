Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbUK3Reh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUK3Reh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUK3Ree
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:34:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54941 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262206AbUK3Reb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:34:31 -0500
Subject: Re: Designing Another File System
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41ABF7C5.5070609@comcast.net>
References: <41ABF7C5.5070609@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101832268.25609.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 16:31:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 04:32, John Richard Moser wrote:
> I've been interested in file system design for a while, and I think I
> may be able to design one.  Being poor, I would like to patent/sell it
> when done; however, whatever the result, I'd assuredly give a free
> license to implement the resulting file system in GPL2 licensed code 

Several other vendors have followed this kind of dual model - MySQL,
Troll Tech and Sleepycat being three obvious examples.

> - - 64 bit indices indicating the exact physical location on disk of
> Inodes, giving a O(1) seek to the Inode itself

Until you get a bad block 8) or want to find it in memory (which is the
usual case)

> 1)  Can Unix utilities in general deal with 64 bit Inodes?  (Most
> programs I assume won't care; ls -i and df -i might have trouble)

You would have to ask a unix source code licensee. For Linux inodes can
be 64bit on 64bit platforms, although you would undoubtedly found some
oddments that were not resolved.

> 4)  What basic information do I absolutely *need* in my Inodes? (I'm
> thinking {type,atime,dtime,ctime,mtime,posix_dac,meta_data_offset,size,\
  links}

See posix 1003.1 and the Single Unix SPecification. That defines the
behaviour.

> 5)  What basic information do I absolutely *need* in my directory
> entries? (I'm thinking {name,inode})

Ditto 

> 6)  How do I lay out a time field for atime/dtime/ctime/mtime?

Internal issue to the file system.


