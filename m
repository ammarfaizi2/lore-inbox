Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310436AbSCLG1G>; Tue, 12 Mar 2002 01:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310437AbSCLG07>; Tue, 12 Mar 2002 01:26:59 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:55274 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S310436AbSCLG0u>; Tue, 12 Mar 2002 01:26:50 -0500
Message-ID: <01eb01c1c98e$e26b8200$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com> <3C8D8376.8010907@mandrakesoft.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Mon, 11 Mar 2002 22:26:46 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>

> Your proposal sounds 100% ok to me...
> 
> For the details of the userspace interface (for both ATA and SCSI), my 
> idea was to use standard read(2) and write(2).
> 
> Any number of programs can open /dev/ata/hda/control or 
> /dev/scsi/sdc/control.  write(2) submits requests, read(2) consumes 
> command responses, perhaps buffering a bit so that multiple responses 
> are not lost if userspace is slow.
> 
> Maybe it's a cheesy way to avoid ioctl(2), maybe not...

Jeff, from a security aspect would it perhaps be better to have the
filter always in place and load rule sets through a rigidly controlled
interface? This gives a control hook for non-Unixoid security model
control over the interface filtering. The filter module would have the
lower level interfaces all opened exclusively so there would be no
paths around the filter. I propose that the rule sets, for each
device's instance of the filter interface, could be changed to include
anything from a null set to forbidding anything past fully controlled
read and write with no raw IO. One specific entity could be allowed
to make the changes and no others. This gives a single interface for
verifying signatures on filter data sets, as well.

{^_^}


