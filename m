Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292729AbSBUTTl>; Thu, 21 Feb 2002 14:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292731AbSBUTTb>; Thu, 21 Feb 2002 14:19:31 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:14295 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S292729AbSBUTTW> convert rfc822-to-8bit;
	Thu, 21 Feb 2002 14:19:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PROBLEM]: 2.4.18-rc1 - Unable to mount CD-ROM/RW
Date: Thu, 21 Feb 2002 13:19:19 -0600
Message-ID: <E0DDC0FF6CE82349A014D7498C36CEE02B5AD9@umr-mail2.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PROBLEM]: 2.4.18-rc1 - Unable to mount CD-ROM/RW
Thread-Index: AcG7C6gmF5lvcvJtRheZyDetlDLH6AAAMnBg
From: "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>
To: "Matt Reppert" <matt@nyu.dyn.dhs.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also used to receive that error with ide-scsi, but it turns out I had
just forgotten to add SCSI-generic support, which is required to use
cdroms through ide-scsi for some reason.

-Matt

-----Original Message-----
From: Matt Reppert [mailto:matt@nyu.dyn.dhs.org] 
Sent: Thursday, February 21, 2002 1:10 PM
To: Shawn Starr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: 2.4.18-rc1 - Unable to mount CD-ROM/RW

On 21 Feb 2002 12:40:35 -0500
Shawn Starr <spstarr@sh0n.net> wrote:
<snip>
>
> When i attempt to mount /dev/cdrom (symlink to /dev/scd0) I get
> 
> mount: /dev/cdrom is not a valid block device (or /dev/scd0).
> 
> What broke? :-(

I got this problem also. Similar config, ATAPI Plextor CDRW using
ide-scsi.
The system would refuse to read/mount CDs unless I did it as root. (eg,
cds wouldn't mount, cdparanoia wouldn't work) Upgrading to -rc2-ac1
seems
to have "fixed" it, have you tried -rc2? (I should try to figure out why
after class, when I actually have time :3 )
--
Matt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
