Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264632AbSJVPC4>; Tue, 22 Oct 2002 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSJVPC4>; Tue, 22 Oct 2002 11:02:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59012 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264632AbSJVPCz>; Tue, 22 Oct 2002 11:02:55 -0400
Date: Tue, 22 Oct 2002 11:10:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jan Kasprzak <kas@informatics.muni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre11 /proc/partitions read
In-Reply-To: <20021022161957.N26402@fi.muni.cz>
Message-ID: <Pine.LNX.3.95.1021022110331.3644A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Jan Kasprzak wrote:

> 	Hello, world!\n
> 
> 	while trying to figure out why my "vgchange -a y" sometimes works
> and sometimes does not, I've come to the following problem:
> 
> # dd if=/proc/partitions bs=512|wc -l
> 1+1 records in
> 1+1 records out
>      12
> 
> # dd if=/proc/partitions bs=128k|wc -l
> 0+1 records in
> 0+1 records out
>      32
> 
> 
> 	I.e. if you read the /proc/partitions in single read() call,
> it gets read OK. However, if you read() with smaller-sized blocks,
> you get the truncated contents.
> 
> 	Are applications expected to read the whole /proc file
> in one read()?
> 
> -Yenya
> 

Well yes, sorta. The proc file-system is a compromise. You can
`cat` it and `more` it, but anything that uses `lseek` will
fail in strange ways.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

