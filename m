Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbRGZPiF>; Thu, 26 Jul 2001 11:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbRGZPh4>; Thu, 26 Jul 2001 11:37:56 -0400
Received: from spring.webconquest.com ([66.33.48.187]:14340 "HELO
	mail.webconquest.com") by vger.kernel.org with SMTP
	id <S267685AbRGZPhp>; Thu, 26 Jul 2001 11:37:45 -0400
Date: Thu, 26 Jul 2001 11:37:42 -0400 (EDT)
From: <sentry21@cdslash.net>
To: Dan Podeanu <pdan@spiral.extreme.ro>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.4.33L2.0107261830410.8540-100000@spiral.extreme.ro>
Message-ID: <Pine.LNX.4.30.0107261136400.18300-100000@spring.webconquest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > sentry21@Petra:1:/$ sudo rm -rf lost+found/
> > rm: cannot unlink `lost+found/#3147': Operation not permitted
> > rm: cannot remove directory `lost+found': Directory not empty
>
> Perhaps:
>
> debugfs -w <your root filesystem>
> unlink /lost+found/#3147

root@Petra:0:~# debugfs -w /
debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
/: Is a directory while opening filesystem
debugfs:  ^D

root@Petra:0:~# debugfs -w /dev/hda5
debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
debugfs:  unlink /lost+found/#3147
debugfs:  ^D

root@Petra:0:~# cd /lost+found/

root@Petra:0:/lost+found# ls -l
total 0
lr----S---    1 52       12337           0 Nov  1  2022 #3147 ->
root@Petra:0:/lost+found#

Apparantly I wasn't joking when I said 'immortal'.

--Dan

