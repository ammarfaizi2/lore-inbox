Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTARNuE>; Sat, 18 Jan 2003 08:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTARNuE>; Sat, 18 Jan 2003 08:50:04 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:384 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264730AbTARNuD>; Sat, 18 Jan 2003 08:50:03 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <robw@optonline.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: reading from devices in RAW mode
Date: Sat, 18 Jan 2003 14:58:53 +0100
Message-ID: <002f01c2bef9$be5682f0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1042896128.1157.4.camel@RobsPC.RobertWilkens.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should clarify my question: I do not really mean reading RAW from
the device, but I want to read RAW like how its on this, without any
error-checking or anything.
Like the "CDROMREADRAW"-ioctl for CD-ROMs.

-----Oorspronkelijk bericht-----
Van: Rob Wilkens [mailto:robw@optonline.net]
Verzonden: zaterdag 18 januari 2003 14:22
Aan: Folkert van Heusden
Onderwerp: Re: reading from devices in RAW mode


Just an idea, but try openning "/dev/fd0" for example -as the floppy-
directly, then "lseek"ing around and reading/writing as necessary.

Same should work for ide (open /dev/hda, or /dev/hdb, etc.) or scsi
(/dev/scd0, etc.).

As per where the useful information is stored on the disk, you'll have
to study filesystem code, and there I couldn't help you.

-Rob

On Sat, 2003-01-18 at 08:16, Folkert van Heusden wrote:
> Maybe I should've sticked to google (altough it wasn't to helpfull this
> time) but
> in this mailinglist there are a lot of knowledgeable people, so here's my
> question:
> for my data-recovery tool I like to read sectors from devices in RAW mode.
> found how to do that for cd-rom, but ide/scsi/floppy still leave me
> clueless.
> Anyone out there who can tell me how to do all of this? (or give me hints
on
> where to find information that google hides from me)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


