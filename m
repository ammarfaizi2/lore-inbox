Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274051AbRISNZx>; Wed, 19 Sep 2001 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274057AbRISNZn>; Wed, 19 Sep 2001 09:25:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20868 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S274051AbRISNZd>; Wed, 19 Sep 2001 09:25:33 -0400
Date: Wed, 19 Sep 2001 09:25:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
cc: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA7C01E.82613672@MissionCriticalLinux.com>
Message-ID: <Pine.LNX.3.95.1010919090014.25310A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Bruce Blinn wrote:
[SNIPPED...]

> I downloaded a copy of cdda2wav and was able to run it.  Here is the
> output:
> 
> # cdda2wav -D0,0,0 -B
> Type: ROM, Vendor 'Lite-On ' Model 'LTN483S 48x Max ' Revision 'PD02'
> cdda2wav:
> Warning: controller returns wrong size for CD capabilities page.
> MMC+CDDA
> 724992 bytes buffer memory requested, 4 buffers, 75 sectors
> #Cdda2wav version 1.11a07_linux_2.4.6-cdrom_i686_i686 real time sched.
> soundcard support
>  DATAtrack recorded      copy-permitted tracktype
>       1- 1 uninterrupted            yes      data
>  DATAtrack recorded      copy-permitted tracktype
>       2- 2   incremental             no      data
> Table of Contents: total tracks:2, (total time 3:10.44)
>   1.[ 0:06.62],  2.[ 3:01.57],
>  
> Table of Contents: starting sectors
>   1.(       0),  2.(     512), lead-out(   14144)
> CDINDEX discid: 9hOr8JVIL3ybrw8DyqAsew8V_MM-
> CDDB discid: 0x0a00bc02
> CD-Text: not detected
> CD-Extra: not detected
> This disk has no audio tracks
> 

Okay. You can see that it was recorded in some "non-standard" way.
"Warning: controller returns wrong size for CD capabilities page."
However, it should not hurt. This shows that there are only two
tracks of data. The rest has never been recorded. Therefore, you
have an ISO9660 image that doesn't fill the whole CD. This seems
okay.

You, therefore, can't get a binary image of the whole CD because
only the first two tracks has been written. A CD isn't "formatted"
like a hard-disk. An unwritten CD doesn't contain anything that
will even synchronize read electronics.

This CD should mount normally under Linux and have no missing or
unreadable files. However, you can't expect to raw-read 700 Mb
of data from the physical media.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


