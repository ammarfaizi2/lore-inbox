Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbULRAQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbULRAQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbULRAQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:16:51 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:8709 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262245AbULRAM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:12:56 -0500
Date: Sat, 18 Dec 2004 01:12:54 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Michelle Konzack <linux4michelle@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3TB disk hassles
Message-ID: <20041218001254.GA8886@pclin040.win.tue.nl>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com> <200412161537.02804.m.watts@eris.qinetiq.com> <20041216155216.GA3854@freenet.de> <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr> <1103212832.21920.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103212832.21920.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 04:00:36PM +0000, Alan Cox wrote:

> Remember you don't need a partition table. You can just leave the volume
> unpartitioned. You can also use other partition formats providing you
> don't need the BIOS boot gunk to boot off that volume. 

Yes, indeed.

One can use a standard DOS-type partition table, and pick a new type -
I reserved 88 for this purpose today - where type 88 indicates a
plaintext partition table found elsewhere on the disk.
Where is elsewhere? In the starting sector of the type 88 partition
(that can have length 1).
This allows one to have the initial part of the disk (at most 2 TB)
partitioned in old-fashioned manner.

The plaintext partition table is just a table with lines
	<start> <size>
that one can edit with emacs or vi.

There is magic to recognize it, namely the line
	"# Plaintext partition table"
and magic to indicate the end of the table, namely "# end".

That is all. If anybody wants it I can send the trivial code.
(Am using it now, but unfortunately I do not have 3 TB disks.)

Comments welcome.

Andries
