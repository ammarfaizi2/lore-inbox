Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270008AbUJSTAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270008AbUJSTAr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269563AbUJSSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:19:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1920 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269998AbUJSRna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:43:30 -0400
Date: Tue, 19 Oct 2004 13:43:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Johan Groth <jgroth@dsl.pipex.com>
cc: Ross Biro <ross.biro@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Dma problems with Promise IDE controller
In-Reply-To: <41754D7B.8090203@dsl.pipex.com>
Message-ID: <Pine.LNX.4.61.0410191340070.4894@chaos.analogic.com>
References: <41741CDB.5010300@dsl.pipex.com>  <58cb370e04101813221d36b793@mail.gmail.com>
  <8783be660410181420683d1341@mail.gmail.com>  <41753E1D.8010608@dsl.pipex.com>
 <8783be660410191013230a1b48@mail.gmail.com> <41754D7B.8090203@dsl.pipex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, Johan Groth wrote:

> Ross Biro wrote:
> [snip]
>
>> 
>> The drive still has a bad sector.  You are having trouble because the
>> error recover in the Linux ide code is not the same as Windows and
>> most drive vendors care about Windows, not the ATA-Spec.  On top of
>> that Linux switches out of DMA mode once it hits a bad sector, so the
>> drive will be very slow from the on.
>> 
>> The only way you are going to fix the problem is if your drive has
>> some spare sectors still available, and you do a write with out a read
>> to the bad sector.
>
> Ok, I pretty sure it has spare sectors. How do I write to that sector without 
> a read and how do I find which sector is bad?
>
> Sorry for all these questions but this is the first time I've had these kind 
> of problems ever. SCSI disks fix bad blocks by themselves so you don't have 
> to do anything.
>
> Regards,
> Johan

man `badblocks`

Also, if you has a BIOS screen when the machine is booting, that
are tools for SCSI (Adaptec has this), then you can use the
SCSI disk utility to replace any bad blocks. Generally, it
reads everything and relocates anything it can't read. You
man end up with corrupt files, but the disk ends up clean.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
