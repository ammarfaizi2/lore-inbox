Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSICPtH>; Tue, 3 Sep 2002 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSICPtH>; Tue, 3 Sep 2002 11:49:07 -0400
Received: from vivi.uptime.at ([62.116.87.11]:7633 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S317263AbSICPtF> convert rfc822-to-8bit;
	Tue, 3 Sep 2002 11:49:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Pitzeier <o.pitzeier@uptime.at>
Organization: UPtime system solutions
To: "Leslie Donaldson" <donaldlf@cs.rose-hulman.edu>,
       axp-kernel-list@redhat.com
Subject: Re: Kernel 2.5.33 successfully compiled
Date: Tue, 3 Sep 2002 17:53:09 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <200209031259.46719.o.pitzeier@uptime.at> <200209031357.48241.o.pitzeier@uptime.at> <3D74D07E.7040101@cs.rose-hulman.edu>
In-Reply-To: <3D74D07E.7040101@cs.rose-hulman.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209031753.09814.o.pitzeier@uptime.at>
X-MailScanner: Nothing found, baby
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 17:08, Leslie Donaldson wrote:
[ ... ]
>  I have had 3 errors so far.
>
> 1. add the following line to
> /usr/src/linux-2.5.X/linux-2.5.33/sound/core/device.c

I don't have sound on this machine, so I don't get any errors in this module.

[ ... ]

> 2. The following file need copied (a quick hack)
>
>          cd include/asm
>           cp ../asm-i386/kmap_types.h  .

I used the same quick-hack, but I was wondering why kmap_types.h is missing... 
Any ideas? Anybody?

> 3. The following error I haven't tried to fix yet.
>
> process.c: In function `alpha_clone':
> process.c:268: too few arguments to function `do_fork'
> process.c: In function `alpha_vfork':
> process.c:277: too few arguments to function `do_fork'
> make[1]: *** [process.o] Error 1
> make[1]: Leaving directory
> `/usr/src/linux-2.5.X/linux-2.5.33/arch/alpha/kernel'
> make: *** [arch/alpha/kernel] Error 2

The same problems happens here. I'm currently searching for the changelog for 
do_fork, so I may find out what arguments I should add to make this working 
again. At the i386-tree there is sometimes "NULL" as the last argument added, 
but I don't believe that it will be good to simply add "NULL" in every 
function call. :o)

Also the quick hack with kmap_types.h doesn't seem very nice to me, but I just 
tried to compile it fine for the first...

Any suggestions from anyone are very welcome! :o)

-- 
Oliver Pitzeier
UNIX Administrator
-
Linux 2.4.19 i686     Load: 0.50 0.39 0.37

