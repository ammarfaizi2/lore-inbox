Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSICP4K>; Tue, 3 Sep 2002 11:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSICP4J>; Tue, 3 Sep 2002 11:56:09 -0400
Received: from ifconfig.de ([139.19.1.1]:5302 "EHLO interferon.mpi-sb.mpg.de")
	by vger.kernel.org with ESMTP id <S318155AbSICPzu>;
	Tue, 3 Sep 2002 11:55:50 -0400
Message-ID: <3D74DC86.31D0162@mpi-sb.mpg.de>
Date: Tue, 03 Sep 2002 18:00:06 +0200
From: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Reply-To: dementiev@mpi-sb.mpg.de
Organization: MPI for Computer Science
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Multi disk performance (8 disks), limit 230 MB/s
References: <3D7104D5.8AD2086B@mpi-sb.mpg.de> <3D7122F4.3FE3BD07@zip.com.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Roman Dementiev wrote:
> >
> > 8 disks:        214 ? 229 ?       40 %           6.7 / 0.8 /10.8
> >
>
> raw access in 2.4 isn't very good - it uses 512-byte chunks.  If
> you can hunt down the `rawvary' patch that might help, but I don't
> know if it works against IDE.
>
> Testing 2.5 would be interesting ;)

I still can't run it, 'interrupt lost' ...

>
>
> Try the same test with O_DIRECT reads or writes against ext2 filesystems.
> That will use 4k blocks.

Thanx, it works. I have got 375 MB/s.

Roman


