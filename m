Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUJCBmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUJCBmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 21:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUJCBmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 21:42:25 -0400
Received: from sa6.bezeqint.net ([192.115.104.20]:10164 "EHLO sa6.bezeqint.net")
	by vger.kernel.org with ESMTP id S267662AbUJCBmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 21:42:22 -0400
Date: Sun, 3 Oct 2004 04:43:35 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3 lost cdrom
Message-ID: <20041003024335.GA4070@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041003021055.GA3227@luna.mooo.com> <1096766301.1375.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096766301.1375.9.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 09:18:21PM -0400, Lee Revell wrote:
> On Sat, 2004-10-02 at 22:10, Micha Feigin wrote:
> > I seem to have lost cdrom support through scsi emulation, any ideas?
> > (its a burner, and drive detection with xcdroast in ide mode is
> > terrible, takes minutes).
> 
> Sounds like an xcdroast bug.  If they finally dropped the scsi emulation
> it would be a welcome change.  It does not make sense to have to use
> some fake SCSI bus to burn CDs on an IDE system.

Not sure if its a bug or a feature ;-) but it does give the message
that its going to take a long time and if I want to make it shorter I
should use scsi emulation and not ide. I don't understand enough about
these to know where the problem lies I'm afraid.

Anyway I got the output of dmesg and was hoping it could shed some more
light on the problem. Seems like a problem with isofs from that:

cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
attempt to access beyond end of device
sr0: rw=0, want=68, limit=4
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
end_request: I/O error, dev sr0, sector 64
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
end_request: I/O error, dev sr0, sector 64
isofs_fill_super: bread failed, dev=sr0, iso_blknum=16, block=16
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0

> 
> Lee 
> 
>  
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.
> 
