Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269035AbRG3Ra5>; Mon, 30 Jul 2001 13:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269031AbRG3Ras>; Mon, 30 Jul 2001 13:30:48 -0400
Received: from web13905.mail.yahoo.com ([216.136.175.68]:27911 "HELO
	web13905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269032AbRG3Rag>; Mon, 30 Jul 2001 13:30:36 -0400
Message-ID: <20010730173044.69085.qmail@web13905.mail.yahoo.com>
Date: Mon, 30 Jul 2001 10:30:44 -0700 (PDT)
From: majordomo kernel <majordomo_kernel@yahoo.com>
Subject: Re: new scsi hardware detection in 2.4.7(pre) 
To: Keith Owens <kaos@ocs.com.au>, Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <24749.996500350@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

It makes more sense if U can send a copy to SCSI group
too.People like Eric and many others only looks at the
linux-scsi group.I think by doing this U can cater to
a wider group of people and more specifically this
sort
of issues are relavant to both -kernel and scsi group.
I hope and expect that in future this will be taken
care of.
Thanx
--- Keith Owens <kaos@ocs.com.au> wrote:
> On Mon, 30 Jul 2001 15:31:17 +0200, 
> Olaf Hering <olh@suse.de> wrote:
> >On Tue, Jul 24, Keith Owens wrote:
> >
> >> On Mon, 23 Jul 2001 17:10:19 +0200, 
> >> Olaf Hering <olh@suse.de> wrote:
> >> >I get this on non-scsi systems with scsi
> compiled into the kernel:
> >> >
> >> >SCSI subsystem driver Revision: 1.00
> >> >request_module[scsi_hostadapter]: Root fs not
> mounted
> >> >request_module[scsi_hostadapter]: Root fs not
> mounted
> >> >request_module[scsi_hostadapter]: Root fs not
> mounted
> >> 
> >> The SCSI midlayer is trying to load the SCSI host
> adapter, that is an
> >> unavoidable side effect of including SCSI
> support.  Because no adapter
> >> is found, kmod tries to automatically load a
> module that can find a
> >> host adapter.  The "Root fs not mounted" message
> occurs when you try to
> >> load any module before / is mounted.
> >
> >Does that make any sense? I mean, there are some
> scsi drivers, none of
> >them found a valid device, why do we look for more
> drivers? It would
> >make sense if there are no low level device drivers
> in the kernel
> >binary.
> 
> There is no way for the mid layer to distinguish
> between "no SCSI card
> configured into kernel" and "SCSI card configured
> but failed to detect
> hardware".  Even when there is a card built into the
> kernel, it still
> makes sense to scan for modules if the initial card
> failed.  That gives
> you fallback to modules when you change your
> hardware.
> 
> If you boot a SCSI kernel on a non-SCSI box then you
> should alias
> scsi_hostadapter off.  You still get the 'Root fs
> not mounted' warning
> messages, just ignore them.  If you are using one
> kernel build for lots
> of different hardware you should be using initrd,
> then the root fs
> messages go away as well.
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
