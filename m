Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTDESxo (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTDESxo (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:53:44 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:7568 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S262620AbTDESxn (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 13:53:43 -0500
Date: Sat, 5 Apr 2003 21:05:37 +0200 (CEST)
From: Stephan van Hienen <kernel@ddx.a2000.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: onboard ICH4 seen as ICH3 (ultra100 controller onboard)
 (2.4.20/2.4.21-pre7)
In-Reply-To: <1049560763.25700.2.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0304052103160.13718@ddx.a2000.nu>
References: <Pine.LNX.4.53.0304051145500.32647@ddx.a2000.nu>
 <1049560763.25700.2.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Alan Cox wrote:

> On Sad, 2003-04-05 at 10:53, kernel@ddx.a2000.nu wrote:
> > mainbord is an intel se7500cw2 (dual xeon)
> > same problem with 2.4.20 and 2.4.21-pre7
>
> I'll take a look. Its probably just a typo in the list of names.
> Its doing UDMA100 so it got the rest of it right 8)

I don't think it is doing U100 :

]# hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.27 seconds =474.07 MB/sec
 Timing buffered disk reads:  64 MB in  2.54 seconds = 25.20 MB/sec

]# hdparm -Tt /dev/hdc

/dev/hdc:
 Timing buffer-cache reads:   128 MB in  0.27 seconds =474.07 MB/sec
 Timing buffered disk reads:  64 MB in  2.58 seconds = 24.81 MB/sec

]# hdparm -Tt /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.27 seconds =474.07 MB/sec
 Timing buffered disk reads:  64 MB in  1.37 seconds = 46.72 MB/sec

(hde= promise U100)

]# hdparm -X69 /dev/hda

/dev/hda:
 setting xfermode to 69 (UltraDMA mode5)

dmesg gives me :

ide0: Speed warnings UDMA 3/4/5 is not functional.
