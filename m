Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288778AbSASNxO>; Sat, 19 Jan 2002 08:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSASNxE>; Sat, 19 Jan 2002 08:53:04 -0500
Received: from [202.87.41.13] ([202.87.41.13]:42177 "HELO postfix.baazee.com")
	by vger.kernel.org with SMTP id <S288778AbSASNwx>;
	Sat, 19 Jan 2002 08:52:53 -0500
Message-ID: <001a01c1a0f0$c8416a50$3c00a8c0@baazee.com>
Reply-To: "Anish Srivastava" <anishs@vsnl.com>
From: "Anish Srivastava" <anishs@vsnl.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <Pine.LNX.4.33L.0201181741280.32617-100000@imladris.surriel.com>
Subject: Re: kswapd kills linux box with kernel 2.4.17
Date: Sat, 19 Jan 2002 19:24:10 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Rik,

Thanks for your help.
I have successfully patched the kernel with your patches
recompiled and installed it on my development system
the hardware of which is identical to my Production machine (e.g. 8CPU, 8GB
RAM)

I compiled the kernel with glibc-2.2.2-10 (redhat)
I did some performance testing on my box by doing a full oracle dump and
running some
big java jobs. Well Kswapd now seems to be behaving....(thankfully!!)

When I do a top it shows me
Mem:  8263740K av, 2967608K used, 5296132K free,       0K shrd,    6120K
buff
Swap: 2048248K av,       0K used, 2048248K free                 2530948K
cached

Now the cached part never gets freed and just keeps piling up & so does the
used memory.
On my production box with (kernel 2.4.13), both cached & memory used
keet on increasing till it exhausts the entire physical RAM and the box
falls over.
It just doesn't swap.....(I thought with 8GB RAM I wouldnt need swap)

Anyways, then I updated the bdflush parameters....after that the memory does
get
reclaimed but only by a small percentage, so it hardly made any
difference..Memory still
keeps on piling up...forcing me to reboot the box everyday.

Do I need to make any changes to bdflush, freepages etc in /proc/sys/vm ??

Also, is it normal for linux to just keep on eating memory even though most
of the
processes are sleeping and not reclaim memory till the physical RAM is
exhausted

Once, again I thank you for your response and assistance. I really look
forward to
hearing from you again!!

Best regards,
Anish Srivastava

----- Original Message -----
From: "Rik van Riel" <riel@conectiva.com.br>
To: "Anish Srivastava" <anishs@vsnl.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 19, 2002 1:12 AM
Subject: Re: kswapd kills linux box with kernel 2.4.17


> On Fri, 18 Jan 2002, Anish Srivastava wrote:
>
> > I am having a box with 8GB RAM and 8 CPU's.
>
> > Can any of you help??
>
> There are two kernel patches which could help you, either
> Andrea Arcangeli's VM patch (available from kernel.org)
> or my -rmap VM patch (available from surriel.com/patches).
>
> kind regards,
>
> Rik
> --
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
>
> http://www.surriel.com/ http://distro.conectiva.com/
>
>

