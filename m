Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSLHKyy>; Sun, 8 Dec 2002 05:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSLHKyy>; Sun, 8 Dec 2002 05:54:54 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:13966 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S265368AbSLHKyx>;
	Sun, 8 Dec 2002 05:54:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: rtilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
Subject: Re: lilo append mem problem in 2.4.20
Date: Sun, 8 Dec 2002 12:02:32 +0100
User-Agent: KMail/1.4.3
References: <3DFDE59F@zathras>
In-Reply-To: <3DFDE59F@zathras>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212081202.32754.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Sunday 08 December 2002 04:28, rtilley wrote:
> Hello,
>
> Compaq proliant 5000 4 way Pentium Pro with 1 GB RAM only uses 12 to 13 MB
> of RAM when I use kernel 2.4.20 with ac1 patch even when I do
> append="mem=1024" in /etc/lilo.conf
>
> RH 7.2 is the distro and its default kernel (2.4.7-10smp), works flawlessly
> with the mem append, it sees and uses all the RAM. But, their latest kernel
> 2.4.18-18.7.xsmp fails to use the RAM as well; it too only sees 12 to 13
> MB... this is why I tried the kernel.org kernel.
>
> I used RH's 686-smp kernel config file to build the 2.4.20-ac1 kernel. I
> turned High Mem support off as I don't think 1 GB is high mem... is it?
> Anyone know how I can use all of the RAM?
>

I had the same problem on an old Compaq 2500 with 320Mb memory,
the following line used to work :
        append="mem=320M"
now I have to use:
        append="mem=exactmap mem=640K@0 mem=319M@1M"
to get the kernel to see all the memory.
So probably you can get it working again with:
        append="mem=exactmap mem=640K@0 mem=1023M@1M"
Maybe you also could do directly: exactmap mem=1024M@0
or 1G@0, but I haven't tried that yet.
It seems the mem parameter now only can be used to limit the amount of memory 
used by the kernel.
-- 

    GertJan
