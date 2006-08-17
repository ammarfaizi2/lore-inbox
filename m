Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWHQOhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWHQOhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWHQOhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:37:09 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:56265 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932524AbWHQOhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:37:07 -0400
Date: Thu, 17 Aug 2006 10:36:33 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 7eggert@gmx.de, Arjan van de Ven <arjan@infradead.org>,
       Dirk <noisyb@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Message-ID: <20060817143633.GF13641@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca> <1155822530.15195.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155822530.15195.95.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 02:48:50PM +0100, Alan Cox wrote:
> Ar Iau, 2006-08-17 am 09:23 -0400, ysgrifennodd Lennart Sorensen:
> > Why can't O_EXCL mean that the kernel prevents anyone else from issuing
> > ioctl's to the device?  One would think that is the meaning of exlusive.
> 
> If you were designing a new OS from scratch you might want to explore
> that semantic as a design idea. I wouldn't recommend it because a lot of
> apps will be upset if they issue an ioctl and it mysteriously fails or
> hangs.

I think hal should get an error when it tries to open the cdrom device
when the burning application is using it.  It shouldn't even get a
chance to issue an ioctl.  I was assuming hal doesn't keep the cdrom
device open at all times (if it does, well that would be stupid).

> Issues of this nature require high level synchronization and that
> (witness email) is generally done in user space which is the only place
> that has transaction level visibility.

Hmm, so how does one tell hal to go to hell and leave the cdrom device
alone at all times (other than totally disabling hal).  Who the heck
wants all that stupid auto crap anyhow. :)

--
Len Sorensen
