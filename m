Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288302AbSACUc0>; Thu, 3 Jan 2002 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288305AbSACUcR>; Thu, 3 Jan 2002 15:32:17 -0500
Received: from tourian.nerim.net ([62.4.16.79]:23822 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S288301AbSACUcN>;
	Thu, 3 Jan 2002 15:32:13 -0500
Message-ID: <3C34BFCA.3010200@free.fr>
Date: Thu, 03 Jan 2002 21:32:10 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml@ohdarn.net, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Second edition of the -mjc branch has been released
In-Reply-To: <200201030929.g039TCZ02342@ohdarn.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml@ohdarn.net wrote:

> Performance and stability issues have been fixed to some degree.
> A lot of the patches I have received either did not have names attached
> or I was unable to locate a name.  Please contact me if changes must
> be made.  All of the patches that have been included in this release can
> be found at:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/included/mjc2
> The release itself is located here:
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/mjc/linux-2.4/current
> 
> Below is a snippet from Changelog.mjc:
> mjc2:
> Reverse Mapping Patch #10                       (Rik van Riel)
> Bootmem patch                                   (William Lee Irwin III)
> entry.S speedups                                (Alex Khripin)
> -fixed entry.S to apply to mjc tree             (Luuk van der Duim)
> NFS Updates                                     (Trond Myklebust)
> kmem_cache_estimate optimization                (Balbir Singh)
> IRQrate                                         (Ingo Molnar)
> Pagecache & Icache hash changes                 (Chuck Lever,
>                                                 William Lee Irwin III,
>                                                 Rusty Russell,
>                                                 Anton Blanchard)
> Voodoo Framebuffer Fixes                        (Jurriaan)
> SiS 5513 Fixes                                  (Lionel Bouton)
> 


SiS 5513:

- Current state:
I had no filesystem corruption on my SIS735 system since latest patch, 
had it reviewed by several readers and think to have put correct init 
code in...


- Warning:
I've not yet gotten the level of testing I'd like to (confirmation on 
other SIS735 and reports for other 5513 derivatives).

With old code ATA100 can work for some not at all for other and even for 
many systems sometime work sometime fail (seems the most probable and 
occured on my configuration).
My guess is that the chip registers don't have a defined value at system 
power on but some random probability of being right.

So I consider these fixes alpha quality untill I have success reports on 
a larger scale.


- So:
If you have SIS IDE and try the mjc branch, please report any success or 
failure directly to me (with sis chipset used it would be good, with 
mainboard model better and with BIOS rev it would be perfect).

It's quite important for future devs as I'm not comfortable with the 
current code (needed too much time to understand in my opinion). I'd 
like to rewrite several chuncks (and in fact began to do so) but am 
waiting for the current fixes to be tested on a larger scale.

> ATI Rage128 Framebuffer Fixes                   (?)
> [...]


LB.

