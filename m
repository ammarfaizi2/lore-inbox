Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265465AbRGEXBv>; Thu, 5 Jul 2001 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265461AbRGEXBl>; Thu, 5 Jul 2001 19:01:41 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:50482 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265465AbRGEXB0>;
	Thu, 5 Jul 2001 19:01:26 -0400
Message-ID: <20010706010107.A1956@win.tue.nl>
Date: Fri, 6 Jul 2001 01:01:07 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>, Aaron Lehmann <aaronl@vitelus.com>
Cc: Stephen C Burns <sburns@farpointer.net>, linux-kernel@vger.kernel.org,
        83710@bugs.debian.org
Subject: Re: [OT] Re: LILO calling modprobe?
In-Reply-To: <20010705224245.A1789@win.tue.nl> <20010705140330.C22723@vitelus.com> <20010705180331.A10315@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010705180331.A10315@animx.eu.org>; from Wakko Warner on Thu, Jul 05, 2001 at 06:03:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 06:03:31PM -0400, Wakko Warner wrote:

> > > Before doing anything LILO v21 collects the hda, hdb, sda, sdb info.
> > > There is no problem, certainly no kernel problem.
> > 
> > Sure it isn't a problem, but it's really annoying if it won't need to
> > touch hda anyway.
> > 
> > Is there a reason that it does this?
> 
> I believe there is.  It wants to find what drive is bios drive 80h.

Yes.

> I had a machine at work with both ide and scsi.  ide hdd was hdc and ide
> cdrom was hda just to keep lilo from thinking hdc is the first bios drive
> which infact sda was

But why don't you use the bios keyword? From lilo.conf(5):

              For example,

                     disk=/dev/sda
                          bios=0x80
                     disk=/dev/hda
                          bios=0x81

              would say that your SCSI disk  is  the  first  BIOS
              disk,  and  your  (primary  master) IDE disk is the
              second BIOS disk.
