Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbTDUBmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 21:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263755AbTDUBmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 21:42:04 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:34059 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S263754AbTDUBmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 21:42:03 -0400
Date: Sun, 20 Apr 2003 18:51:27 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030421015127.GA11606@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1050864521.11658.8.camel@dhcp22.swansea.linux.org.uk> <200304202000.h3KK0GsX000976@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304202000.h3KK0GsX000976@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 09:00:16PM +0100, John Bradford wrote:
> > > I know you favor a layer between low-level driver and fs
> > > probably. Sure it is clean design, and sure it sounds like
> > > overhead (Yet Another Layer).
> > 
> > Wrong again - its actually irrelevant to the cost of mirroring data, the cost
> > is entirely in the PCI and memory bandwidth. The raid1 management overhead is
> > almost nil
> 
> Actually what I was suggesting was even simpler - in the unlikely
> event that we were talking about an MFM or similar interface disk that
> _was_ basically like a big floppy, and did no error correction of it's
> own, we _could_ reserve, say, one sector per track, and create a 
> fault tollerant device that substituted the spare sector in the event
> of a write fault.
> 
> The overhead would probably be exactly zero, becuase nobody would
> actually compile the feature in and use it :-).

UFS used to do this because of MFM disks.  In building a
filesystem you could provide a list of bad blocks and the
filesystem would maintian a block remap table.  On Solaris
at least the reserved space is still required.  By the time
most of the modern filesystems were created any hard disk
worth using in production had its own CPU and memory and
merely emulated a disk drive to the host while managing zone
recording and block remapping internally. 

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
