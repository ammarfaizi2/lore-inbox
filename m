Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWAKPpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWAKPpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 10:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWAKPpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 10:45:05 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:20164 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751497AbWAKPpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 10:45:04 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'jerome lacoste'" <jerome.lacoste@gmail.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Robert Hancock'" <hancockr@shaw.ca>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: ata errors -> read-only root partition. Hardware issue?
Date: Wed, 11 Jan 2006 09:55:01 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYWwonrdZsNyJ9xQrmnZUKg+LCeBQABKe+Q
In-Reply-To: <5a2cf1f60601110726r46805e1dl784f0a0ca20c128@mail.gmail.com>
Message-ID: <EXCHG2003ifWoqFXfyY00000b2a@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 11 Jan 2006 15:38:42.0850 (UTC) FILETIME=[1A13A020:01C616C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> jerome lacoste
> Sent: Wednesday, January 11, 2006 9:26 AM
> To: Alan Cox
> Cc: Robert Hancock; linux-kernel
> Subject: Re: ata errors -> read-only root partition. Hardware issue?
> 
> On 1/11/06, jerome lacoste <jerome.lacoste@gmail.com> wrote:
> > On 1/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > On Mer, 2006-01-11 at 09:30 +0100, jerome lacoste wrote:
> > > > - scan for bad blocks
> > >
> > > Read the entire disk (write will hide and clean up errors by
> > > reallocating)
> >
> > something like should be sufficient right?
> >
> > cat /dev/sdax > /dev/null
> 
> I did something slightly different:
> 
> root@manies:~# cat /dev/sda > /dev/null
> cat: /dev/sda: Input/output error
> 
> and in dmesg, problems show again:
> 
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> SCSI error : <2 0 0 0> return code = 0x8000002
> sda: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sda, sector 39088832 Buffer I/O 
> error on device sda, logical block 4886104
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x40 { UncorrectableError }
> ....


If it is repeatable on the exact same block(s)/sector(s) every time,
and it reads lots of other blocks/sectors just fine, it is very
unlikely to be anything but a disk error.

                       Roger

