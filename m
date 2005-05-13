Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVEMSxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVEMSxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVEMSxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:53:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59082 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262479AbVEMSmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:42:04 -0400
Subject: Re: Sync option destroys flash!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mhw@wittsend.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116001207.5239.38.camel@localhost.localdomain>
References: <1116001207.5239.38.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116009619.9371.494.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 19:40:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	What happens, with the sync option on a VFAT file system, is that the
> FAT tables are getting pounded and over-written over and over and over
> again as each and every block/cluster is allocated while a new file is
> written out.  This constant overwriting eventually wears out the first
> block or two of the flash drive.

All non-shite quality flash keys have an on media log structured file
system and will take 100,000+ writes per sector or so. They decent ones
also map out bad blocks and have spares. The "wear out the same sector"
stuff is a myth except on ultra-crap devices.

> 	I'm also going to file a couple of bug reports in bugzilla at RedHat
> but this seems to be a more fundamental problem than a RedHat specific
> problem.  But, IMHO, they should never be setting that damn sync flag
> arbitrarily.

It sounds like your need to find a vendor who makes decent keys. For
that matter several vendors now offer life time guarantees with their
USB flash media.

Sync gets set by RH because it seemed the right thing to do to handle
random user device pulls. Now O_SYNC works so excessively well on
fat/vfat that needs looking at - and as you say likewise perhaps the
nature of the FAT rewriting.

However its not a media issue, its primarily a performance issue.

Alan

