Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBOXK0>; Thu, 15 Feb 2001 18:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129936AbRBOXKQ>; Thu, 15 Feb 2001 18:10:16 -0500
Received: from gear.torque.net ([204.138.244.1]:3599 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129294AbRBOXKC>;
	Thu, 15 Feb 2001 18:10:02 -0500
Message-ID: <3A8C607E.8AB567CC@torque.net>
Date: Thu, 15 Feb 2001 18:04:30 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: German Gomez Garcia <kahuna@ksoft.dnsalias.net>
Subject: Re: Manual SCSI bus reset?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

German Gomez Garcia wrote:

>         I've got Plexwriter 12x10x32S attached to an onbard AIC7890
> (besides other things as three IBM UWSCSI harddisks, an SCSI ZIP and a
> Pioneer DVD) and sometimes when recording a CD the Plexwriter fails at the
> very end of the process (although the CD is recorded correctly) and it is
> locked with no posibility to eject it (it seems that a failure while
> reading from the DVD during on-the-fly recording is the cause). 
>
>         But if I reset the SCSI bus manually, that is trying to read from
> a "reset-it CD", that is completely broken and makes the SCSI bus resets
> itself, I can eject the CD from the Plexwriter. So I would like to know if
> there is a way to do it without that trick. I've downloaded some utilities
> for the SCSI generic driver, one of them should let you reset the bus (or
> even just a single device) but it fails with "SCSI_RESET" not supported
> and after reading through the docs it seems that the kernel (or should I
> say the SCSI drivers) doesn't support this kind of reset.
>        
>         I would like to know if this is "kernel politics", "faulty
> hardware", or just lazy programmers ;-), thanks and please CC the answer
> to me as I'm not subscribed to this mailing list.

Various distributions (e.g. RH 7.0) contain the SCSI 
mid-level patch that will permit the sg_reset utility
to perform a scsi bus reset. [The same patch makes the 
scsi subsystem respect device reservations.]

The patch originates from James Bottomley (see the linux-scsi
list archive) and he has submitted a new version for the lk 2.4
tree recently. When first submitted, objections were raised to 
the concept of allowing users to do scsi bus resets (see same 
list archive). 

There is a chance that the required patch will go into main 
kernel tree soon.

Doug Gilbert
