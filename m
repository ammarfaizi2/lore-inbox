Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbRGZQFf>; Thu, 26 Jul 2001 12:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268265AbRGZQF0>; Thu, 26 Jul 2001 12:05:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49280 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268223AbRGZQFV>; Thu, 26 Jul 2001 12:05:21 -0400
Date: Thu, 26 Jul 2001 12:05:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sentry21@cdslash.net
cc: Dan Podeanu <pdan@spiral.extreme.ro>, linux-kernel@vger.kernel.org
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.4.30.0107261150020.18300-100000@spring.webconquest.com>
Message-ID: <Pine.LNX.3.95.1010726115915.17866A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001 sentry21@cdslash.net wrote:

> > > root@Petra:0:~# debugfs -w /
> > > debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> > > /: Is a directory while opening filesystem
> > > debugfs:  ^D
> > >
> > > root@Petra:0:~# debugfs -w /dev/hda5
> > > debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> > > debugfs:  unlink /lost+found/#3147
> > > debugfs:  ^D
> >         ^^^^^^^^
> > How about 'Q' so debugfs gets to write the modifications to the
> > drive?
> 
> root@Petra:0:/lost+found# debugfs -w /dev/hda5
> debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> debugfs:  unlink /lost+found/#3147
> unlink_file_by_name: No free space in the directory
> 
> 
> This is getting weirder and weirder.
> 
Okay, the file is a link, linked to /lost+found. So, using debugfs,
just remove the directory:
# debugfs -w /dev/hda5
debugfs: rmdir /lost+found

My debugfs is too old, so the above command replies with "Unimplemented".



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


