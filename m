Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWHQNXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWHQNXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWHQNXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:23:18 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:56454 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932485AbWHQNXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:23:18 -0400
Date: Thu, 17 Aug 2006 09:23:09 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Message-ID: <20060817132309.GX13639@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155821951.15195.85.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 02:39:11PM +0100, Alan Cox wrote:
> man 3 sleep
> man 2 flock
> 
> or in the GUI world I'm firmly assured that the sun shines out of the
> arse of dbus for intra desktop communication.
> 
> Lots of solutions.
> 
> We could certainly add an ioctl for this in the new libata layer. We
> couldn't automate it as with pass through commands the kernel doesn't
> really know what kind of exclusivity is needed and when.
> 
> Not sure its actually useful but its doable.

Why can't O_EXCL mean that the kernel prevents anyone else from issuing
ioctl's to the device?  One would think that is the meaning of exlusive.
That way when the burning program opens the device with O_EXCL, no one
else can screw it up while it is open.  If it happens to be polled by
hal when the burning program tries to open it, it can just wait and
retry again until it gets it open.

--
Len Sorensen
