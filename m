Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274099AbRIXVur>; Mon, 24 Sep 2001 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273998AbRIXVuh>; Mon, 24 Sep 2001 17:50:37 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:62753 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273663AbRIXVuW>; Mon, 24 Sep 2001 17:50:22 -0400
Subject: Re: report: success with agp_try_unsupported=1
From: Robert Love <rml@ufl.edu>
To: Peter Jay Salzman <p@dirac.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010924144006.A13695@dirac.org>
In-Reply-To: <20010924144006.A13695@dirac.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 24 Sep 2001 17:50:38 -0400
Message-Id: <1001368244.1194.27.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-24 at 17:40, Peter Jay Salzman wrote:
> i just built a system:
> 
> 	1.3GHz amd athlon
> 	epox 8kha ddr motherboard
> 		via kt266 (vt8366, vt8233)
> 	768MB ddr ram
> 	radeon QD with 64MB video buffer, tvio
> 
> i enabled agpgart, and got the message:
> 
> 
>   Linux agpgart interface v0.99 (c) Jeff Hartmann
>   agpgart: Maximum main memory to use for agp memory: 690M
>   agpgart: Unsupported Via chipset (device id: 3099), you might want to try
>     agp_try_unsupported=1.
>   agpgart: no supported devices found.
>   [drm] Initialized radeon 1.1.1 20010405 on minor 0

I will write a patch for this to add VIA KT266 support (so you don't
need to do the agp_try_unsupported=1 mess, it will be supported
natively).  Although, the patch is going to be against 2.4.10.

I'll send it out in a sec, start downloading 2.4.10 :)

> 2. i recompiled the kernel but built agpgart in rather than loading it as a
>    module.  i then inserted the following line into /etc/lilo.conf:
> 
>       append="agp_try_unsupported=1"
> 
>    but it didn't seem to work.  someone told me that to get agp work to work
>    for my system, agpgart MUST be built as a module and you MUST pass it the
>    argument agp_try_unsupported=1.  in other words, you can't build it into

Yes, I believe this is a bug.  Maybe I should take a look at it...

agpgart doesn't read the command line, or not correctly, or something.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

