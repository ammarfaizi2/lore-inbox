Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272602AbRHaEXp>; Fri, 31 Aug 2001 00:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272603AbRHaEXe>; Fri, 31 Aug 2001 00:23:34 -0400
Received: from [209.218.224.101] ([209.218.224.101]:10881 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S272602AbRHaEXT>; Fri, 31 Aug 2001 00:23:19 -0400
Message-ID: <001301c131d4$de9180f0$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c13179$be7b9ae0$6caaa8c0@kevin> <shsd75d2whg.fsf@charged.uio.no>
Subject: Re: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same mountpoint
Date: Thu, 30 Aug 2001 21:24:47 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was expecting it to be an error, but I'm not upset that it's not. Just
kind of weird to see five mounts with the exact same information in
/etc/mtab.

I can see why it would be useful to have multiple things mounted on the same
mountpoint, but is there any reason to allow the _same_ filesystem to be
mounted multiple times at the same mountpoint?

----- Original Message -----
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 30, 2001 12:12 PM
Subject: Re: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same
mountpoint


> >>>>> " " == Kevin P Fleming <kevin@labsysgrp.com> writes:
>
>      > Accidentally <G> I mounted a filesystem from my server onto my
>      > workstation twice. Mount gave me no error....
>
> That's right. The 2.4 VFS removed the global restriction on the number
> of mounts on a single mountpoint. So?
>
> If people expect this to be an error, then the correct thing is for
> the VFS restriction to be reinstated. I see no reason why it should be
> the responsibility of the filesystem to check for this sort of
> thing. A mountpoint is after all the one place where the VFS is
> actually *designed* to override the filesystem.
>
> Cheers,
>   Trond
>
>
>

