Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281667AbRKUIFL>; Wed, 21 Nov 2001 03:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281666AbRKUIEv>; Wed, 21 Nov 2001 03:04:51 -0500
Received: from [212.3.242.3] ([212.3.242.3]:52230 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S281665AbRKUIEq>;
	Wed, 21 Nov 2001 03:04:46 -0500
Message-Id: <5.1.0.14.2.20011121085726.00aaf648@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Nov 2001 08:58:35 +0100
To: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>, linux-kernel@vger.kernel.org
From: DevilKin <devilkin@gmx.net>
Subject: Re: 2.4.14 loopback blk dev compilation trouble
In-Reply-To: <3BFBBE98.68052D11@sltnet.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:47 21/11/2001 -0600, Ishan Oshadi Jayawardena wrote:
>Greetings.
>         I've seen that the compilation of off-the-server
>2.4.14 tree fails at the end of 'make bzImage' because
>drivers/block/loop.c uses the deactivate_page() function,
>which seems to have been removed from the source tree.
>         By following the progress of the kernel through
>2.4.12, 2.4.13, and 2.4.14 patches, I've seen that
>page_cache_release() does the same things as
>deactivate_page(). Both these functions are used in the
>together twice in drivers/block/loop.c. I compiled
>the 2.4.14 kernel by commenting out the references to
>deactivate_page() but leaving page_cache_release(), and
>loopback block devs work; but I do not have the resources
>to  check it for memory leaks etc.
>         I _think_ I've done the right thing, but
>would appreciate verification by a regular kernel-
>hacker :-)
>I searched the net for some reference to this problem,
>but couldn't find anything so far.
>
>(I've compiled loop blk-dev support in to the kernel.)

That's the correct way to correct the compilation problem. It has been 
reported 22987432 times already...

DK

