Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264463AbRGEV6e>; Thu, 5 Jul 2001 17:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbRGEV6Z>; Thu, 5 Jul 2001 17:58:25 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:21262
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S264463AbRGEV6N>; Thu, 5 Jul 2001 17:58:13 -0400
Date: Thu, 5 Jul 2001 18:03:31 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Guest section DW <dwguest@win.tue.nl>,
        Stephen C Burns <sburns@farpointer.net>, linux-kernel@vger.kernel.org,
        83710@bugs.debian.org
Subject: Re: [OT] Re: LILO calling modprobe?
Message-ID: <20010705180331.A10315@animx.eu.org>
In-Reply-To: <20010705224245.A1789@win.tue.nl> <20010705140330.C22723@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20010705140330.C22723@vitelus.com>; from Aaron Lehmann on Thu, Jul 05, 2001 at 02:03:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     cache_add("/dev/hda",0x300);
> >     for (i = 1; i <= 8; i++) {
> >         sprintf(tmp,"/dev/hda%d",i);
> >         cache_add(tmp,0x300+i);
> > 
> > Before doing anything LILO v21 collects the hda, hdb, sda, sdb info.
> > There is no problem, certainly no kernel problem.
> 
> Sure it isn't a problem, but it's really annoying if it won't need to
> touch hda anyway.
> 
> Is there a reason that it does this?

I believe there is.  It wants to find what drive is bios drive 80h.  Really
annoying since there's no way (correct me if I'm wrong) to read bios from
linux.  If there is, lilo should do that.  But since it's an old copy, this
probably was fixed.

I had a machine at work with both ide and scsi.  ide hdd was hdc and ide
cdrom was hda just to keep lilo from thinking hdc is the first bios drive
which infact sda was

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
