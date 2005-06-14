Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFNHzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFNHzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFNHzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:55:22 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:25626 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261312AbVFNHzI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:55:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W03YkyyWKMYVzYl56San0B/qHtS357VDu7VfVa0/oNRNtJDQIDd1egMU68oyW6gl7rMOkFJcZumQWBjNDzUr41pJHvKBKL/hsTdrkmVlelpOgq1gUBDp44vp63jmwcf2nU17Gt3Zf03QC4iyDqEFEaI6Ud4bsMuoxU44M9AefSQ=
Message-ID: <58cb370e05061400555407d144@mail.gmail.com>
Date: Tue, 14 Jun 2005 09:55:08 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jeff Wiegley <jeffw@cyte.com>
Subject: Re: amd64 cdrom access locks system
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <42ADB5B4.1020704@cyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org>
	 <42A861F8.9000301@cyte.com> <20050609160045.69c579d2.akpm@osdl.org>
	 <42ADB5B4.1020704@cyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Jens added to cc: ]

On 6/13/05, Jeff Wiegley <jeffw@cyte.com> wrote:
> Andrew Morton said I should carbon copy the IDE developer on this
> issue so I have in the hopes of re-opening this issue and making
> some progress since I'm still unable to write anything with my
> cd-burner.
> 
> Here's what I know to date:
> 
>     I have the alim15x3 IDE driver installed and running.
>     I do NOT have any of the generic IDE drivers installed or
>        even compiled as they grossly interfere with the alim15x3
>        and cause a kernel panic.
>     My hardware is an AMD64 FX55 in a Shuttle ST20G5 case with a
>        serial ATA harddrive.
>     I'm using a stock 2.6.12-rc6 kernel.
>     Debian unstable distribution.
> 
> At first I can read from the drive fine.
>     For instance I did two "cdparanoia -B -d /dev/hda" without
>     a hitch. Nothing was reported in /var/log/kernel as a result.
> 
> The problem is that I can't write to the drive (burn cds with
> cdrecord) with causing a lost interrupt and then nothing works;
> even reads don't respond.
> 
> When I do:
>     cdrecord -v -tao dev=ATAPI:/dev/hda something.iso
> 
> I get this output:
>    Cdrecord-Clone 2.01.01a01 (x86_64-unknown-linux-gnu) Copyright (C)
> 1995-2004 Joerg Schilling
>    NOTE: this version of cdrecord is an inofficial (modified) release of
> cdrecord
>          and thus may have bugs that are not present in the original
> version.
>          Please send bug reports and support requests to
> <cdrtools@packages.debian.org>.
>          The original author should not be bothered with problems of
> this version.
> 
>    cdrecord: Warning: Running on Linux-2.6.12-rc6-jw14
>    cdrecord: There are unsettled issues with Linux-2.5 and newer.
>    cdrecord: If you have unexpected problems, please try Linux-2.4 or
> Solaris.
>    TOC Type: 1 = CD-ROM
>    scsidev: 'ATAPI:/dev/hda'
>    devname: 'ATAPI:/dev/hda'
>    scsibus: -2 target: -2 lun: -2
>    Warning: Using ATA Packet interface.
>    Warning: The related Linux kernel interface code seems to be
> unmaintained.

^^^

>    Warning: There is absolutely NO DMA, operations thus are slow.

^^^

What is the result of using "dev=/dev/hda" interface instead
(as suggested by Robert)?

Bartlomiej
