Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288905AbSAER5c>; Sat, 5 Jan 2002 12:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288907AbSAER5W>; Sat, 5 Jan 2002 12:57:22 -0500
Received: from white.pocketinet.com ([12.17.167.5]:55671 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S288905AbSAER5O>; Sat, 5 Jan 2002 12:57:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Date: Sat, 5 Jan 2002 09:57:17 -0800
X-Mailer: KMail [version 1.3.1]
Cc: kernel@theoesters.com, linux-kernel@vger.kernel.org
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp> <WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com> <20020105161958.43d7ab25.skraw@ithnet.com>
In-Reply-To: <20020105161958.43d7ab25.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEkvVMLaWYzfZRzD00000ce9@white.pocketinet.com>
X-OriginalArrivalTime: 05 Jan 2002 17:55:42.0994 (UTC) FILETIME=[31AACF20:01C19612]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 January 2002 07:19 am, Stephan von Krawczynski wrote:
> On Fri, 4 Jan 2002 16:42:43 -0800
>
> Nicholas Knight <nknight@pocketinet.com> wrote:
> > I have absilutely no trouble reproducing on an 800MHz Athlon with
> > 256MB RAM/256MB swap on 2.4.17
>
> The simple question is: is the RAM sufficient at all to spawn such a
> lot of cc processes? In my setup I get around 1000 concurrently
> working during -j. This sounds like a real problem for 256/256, or
> not?

Matter of scale, did you try a full kernel build with make -j bzImage 
using whatever your normal config is?
I still believe this is an innappropriate test, sure if you have tons 
of RAM and swap it may eventualy complete (though if the swapfile is 
very active and this is tried on a 2.4 kernel, the amount of CPU time 
the compile will actually get will likely be unpredictable at best.) 
This is an option that does nothing less than flood the system with 
hundreds or thousands of processes that on any large compile will 
simply not allow the system to survive intact without killing all the 
processes. Does the OOM killer even work correctly yet? Or does it 
still try to kill init at times? And for that matter, what order does 
it kill in?

>
> Regards,
> Stephan

