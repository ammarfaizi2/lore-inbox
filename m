Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312216AbSCRGnx>; Mon, 18 Mar 2002 01:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312215AbSCRGnm>; Mon, 18 Mar 2002 01:43:42 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28688 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312213AbSCRGnZ>; Mon, 18 Mar 2002 01:43:25 -0500
Message-Id: <200203180639.g2I6dVq27119@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Felix Braun <Felix.Braun@mail.McGill.ca>, rgooch@atnf.csiro.au
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
Date: Mon, 18 Mar 2002 08:39:02 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020317121954.390bc242.Felix.Braun@mail.McGill.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 March 2002 09:19, Felix Braun wrote:
> Hi Richard,
>
> I just noticed that devfs is listed twice in /proc/mounts in linux
> 2.4.19-pre3, which confuses my shutdown script. Under 2.4.19-pre my
> /proc/mounts looks like this:
>
> devfs /dev devfs rw 0 0
> /dev/ide/host0/bus0/target0/lun0/part5 / reiserfs rw 0 0
> none /dev devfs rw 0 0
> /proc /proc proc rw 0 0
> /dev/discs/disc0/part1 /dos vfat rw 0 0
> /dev/discs/disc0/part9 /opt reiserfs rw,noatime 0 0
> none /dev/pts devpts rw 0 0
> /dev/discs/disc0/part7 /usr reiserfs rw 0 0
> none /dev/shm tmpfs rw 0 0
>
> whereas under 2.4.18 the first line didn't show up. Is that a
> misconfiguration on my part?

Maybe you mount devfs manually after kernel did the same?
devfs /dev devfs rw 0 0 - most probably mounted by initscripts
none /dev devfs rw 0 0 - by kernel

Look into /var/log/messages for:
kernel: VFS: Mounted root (nfs filesystem).
kernel: Mounted devfs on /dev   <============ do yo have this?
--
vda
