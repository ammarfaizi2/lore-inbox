Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315462AbSEGON6>; Tue, 7 May 2002 10:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSEGON5>; Tue, 7 May 2002 10:13:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:8972 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315462AbSEGON5>;
	Tue, 7 May 2002 10:13:57 -0400
Message-ID: <3CD7D268.3050401@evision-ventures.com>
Date: Tue, 07 May 2002 15:11:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Anton Altaparmakov <aia21@cantab.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <20020507160825.S22215@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Dave Jones napisa?:
> On Tue, May 07, 2002 at 02:57:46PM +0100, Anton Altaparmakov wrote:
>  > How do I get this information with hdparm please?
>  > 
>  > [aia21@drop ide]$ cat via
> 
> Bartlomiej Zolnierkiewicz moved all this stuff to userspace
> a long time ago in 'ideinfo'.
> 
>  > [aia21@drop hda]$ cat cache
>  > 1916
>  > [aia21@drop hda]$ cat capacity
>  > 80418240
>  > [aia21@drop hda]$ cat geometry
>  > physical     79780/16/63
>  > logical      5005/255/63
>  > 
>  > And hdparm never gives you the physical geometry AFAICS.
> 
> Why would a normal user ever need to know this info?
> 
>  > And as I said, I can understand removing the ability to write values into 
>  > /proc/ide/*, what I disagree with is the removal of the information 
>  > provided by read-only access to /proc/ide/*. And that is because I am not 
>  > aware of any other way to get the same information.
> 
> The parsing gunk we have for /proc/ide is fugly, and should have been
> done with sysctls from day one imo.

Amen. For where it turn outs to be really really worth it
I indeed plan to move to sysctl. For example currently
we have on ioctl level still the problem that many of
them are attached to the device but act on the channel.

hdparm -xxx /dev/hda & hdparm -xxx /dev/hdc - BANG race condition.
(At least on the level of logics).

