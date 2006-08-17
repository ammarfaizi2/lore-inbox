Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWHQNz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWHQNz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWHQNyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:54:50 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:36507 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S964865AbWHQNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:54:36 -0400
Date: Thu, 17 Aug 2006 09:54:31 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de,
       Arjan van de Ven <arjan@infradead.org>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Message-ID: <20060817135431.GE13641@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca> <44E471F2.5000003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E471F2.5000003@garzik.org>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 09:41:06AM -0400, Jeff Garzik wrote:
> Lennart Sorensen wrote:
> >Why can't O_EXCL mean that the kernel prevents anyone else from issuing
> >ioctl's to the device?  One would think that is the meaning of exlusive.
> >That way when the burning program opens the device with O_EXCL, no one
> >else can screw it up while it is open.  If it happens to be polled by
> >hal when the burning program tries to open it, it can just wait and
> >retry again until it gets it open.
> 
> Such use of O_EXCL is a weird and non-standard behavior.

So what method exists for opening a file/device an guaranteeing that
nothing else can do anything to it?

Looking an man 2 open, I can't even see any way O_EXCL even has a normal
meaning for a device, so how much more "weird and non-standard" would it
be to have it control exclusive access to a device?  It appears it is
only supposed to have a meaning for creating files.

--
Len Sorensen
