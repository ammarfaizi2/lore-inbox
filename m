Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTLQWWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTLQWWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:22:39 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25220 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264591AbTLQWWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:22:36 -0500
Date: Wed, 17 Dec 2003 17:25:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: jshankar <jshankar@CS.ColoState.EDU>
cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system
In-Reply-To: <3FF129DA@webmail.colostate.edu>
Message-ID: <Pine.LNX.4.53.0312171720020.32724@chaos>
References: <3FF129DA@webmail.colostate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, jshankar wrote:

> Hello,
>
> Does the  ext3 file systems have to wait for the acknowledgement of block of
> data written to the SCSI device before writing the next block of data.
>

No. Many SCSI drives and adapters allow queued commands and disconnect
operation.

> Is there a parallel I/O where the file system goes on writing the block of
> data
> without waiting for the acknowledgement.
>

This is the normal mode of operation.

> Please let me know your opinion.
>
> Thanks
> Jayshankar
>

Normal Unix/Linux file-systems write data to RAM. At some unknown
time, when memory gets tight, some data are written to the device.

Basically with Unix/Linux, you are using a RAM-Disk that overflows
to the physical media. There are special file-systems (journaling)
that guarantee that something, enough to recover the data, is
written at periodic intervals.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


