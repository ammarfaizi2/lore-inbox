Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSKWPKF>; Sat, 23 Nov 2002 10:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSKWPKF>; Sat, 23 Nov 2002 10:10:05 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:31347 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S267041AbSKWPKE>;
	Sat, 23 Nov 2002 10:10:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Updated Documentation/kernel-parameters.txt (resent, v3)
Date: Sat, 23 Nov 2002 16:17:08 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021123093600.GV25628@pasky.ji.cz>
In-Reply-To: <20021123093600.GV25628@pasky.ji.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211231617.08772.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Petr,

Nice work.
Can you add/change the comments for the mem and mem=exactmap parameters.
The mem parameter doesn't behave in the same manner as it did before 
2.4.19/20, I think it changed somewhere in the 2.4.19-pre series.
On an old Compaq 2500 with 320Mb memory the following line used to work :
	append="mem=320M"
now I have to use:
	append="mem=exactmap mem=640K@0 mem=319M@1M"
to get the kernel to see all the memory.
On later kernels if I use mem=320M it only sees 16Mb, this is also true for 
2.5.44 (probably true for all the 2.5.x kernels) which I tried on that box.
I don't know if it's only something specific for that box and maybe not 
necessarily true for other systems which have to use the mem parameter.
To me it looks like the mem parameter can now only be used to specify less 
memory then the kernel actually recognizes.

Also can you add how to use the mem=exactmap parameter, it says now that such 
lines can be constructed based on BIOS output or other requirements, that 
doesn't tell me how such a line should look like, I only found out how to use 
it by searching through posts on lkml, maybe you can add the above append 
lines as an example.

Regards,

	GertJan


On Saturday 23 November 2002 10:36, Petr Baudis wrote:

>   Hello,
>
>   this patch (against 2.5.49) updates Documentation/kernel-parameters.txt
> to the current state of kernel. It was somehow abadonded lately, so I did
> my best, but it's possible that I still missed some of the options - thus,
> if you will notice your favourite boot option missing there, please speak
> up. Note also that I will probably send up another update after few further
> kernel releases..
>
>   Also, I attempted to introduce some uniform format to the entries, I
> added the format description where I was able to find it out and decypher
> it, and I also added gross amount of external links to the headers of the
> source files or to the README-like files, where the options are described
> into more degree. This way, hopefully this file has a chance to be actually
> usable for the users ;-).
>
>   There are almost certainly some entries which I missed, it was really a
> huge number and the main reason is that some of the boot options don't use
> the __setup macro, which I grep'd for.
>
>   I hope the patch is ok, there should be no problems with it. Please
> apply.
>
>  Documentation/kernel-parameters.txt |  811
> +++++++++++++++++++++++++++--------- 1 files changed, 627 insertions(+),
> 184 deletions(-)
>
>   Note that this is the fourth submission of the patch - I took the
> opportunity and updated the patch from 2.5.48 to 2.5.49. AFAIK mutt
> shouldn't mangle the patch in any way, so it should apply cleanly to your
> tree, Linus.
>
>   Kind regards,
> 				Petr Baudis

