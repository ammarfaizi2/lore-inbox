Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSLWN30>; Mon, 23 Dec 2002 08:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSLWN30>; Mon, 23 Dec 2002 08:29:26 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:2569 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264842AbSLWN3Z>; Mon, 23 Dec 2002 08:29:25 -0500
Message-Id: <200212231325.gBNDOks10718@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Torben Frey <kernel@mailsammler.de>, linux-kernel@vger.kernel.org
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Date: Mon, 23 Dec 2002 16:13:37 -0200
X-Mailer: KMail [version 1.3.2]
References: <3E00C738.1070506@mailsammler.de>
In-Reply-To: <3E00C738.1070506@mailsammler.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 December 2002 17:06, Torben Frey wrote:
> Hi list readers (and hopefully writers),
>
> after getting crazy with our main server in the company for over a
> week now, this list is possibly my last help - I am no kernel
> programmer but suscpect it to be a kernel problem. Reading through
> the list did not help me (although I already thought so, see below).
>
> We are running a 3ware Escalade 7850 Raid controller with 7 IBM
> Deskstar GXP 180 disks in Raid 5 mode, so it builds a 1.11TB disk.
> There's one partition on it, /dev/sda1, formatted with Reiserfs
> format 3.6. The Board is an MSI 6501 (K7D Master) with 1GB RAM but
> only one processor.
>
> We were running the Raid smoothly while there was not much I/O - but
> when we tried to produce large amounts of data last week, read and
> write performance went down to inacceptable low rates. The load of
> the machine went high up to 8,9,10... and every disk access stopped
> processes from responding for a few seconds (nedit, ls). An "rm" of
> many small files made the machine not react to "reboot" anymore, I
> had to reset it.

Can you provide solid numbers (say Mb/s) of single dd's of varying
size? Of concurrent dd's? etc...

> When I am working all alone on the disk creating a 1 GB file by
> time dd if=/dev/zero of=testfile bs=1G count=1
> results in real times from 14 seconds when I am very lucky up to 4
> minutes usually.
> Watching vmstat 1 shows me that "bo" drops quickly down from rates in
> the 10 or 20 thousands to low rates of about 2 or 3 thousands when
> the runs take so long.

Yes, and provide us with vmstat, top, cat /proc/meminfo output
and the like!
--
vda
