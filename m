Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbRE2D53>; Mon, 28 May 2001 23:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbRE2D5U>; Mon, 28 May 2001 23:57:20 -0400
Received: from mail1.netcabo.pt ([212.113.161.135]:44555 "EHLO netcabo.pt")
	by vger.kernel.org with ESMTP id <S262194AbRE2D5G>;
	Mon, 28 May 2001 23:57:06 -0400
Message-ID: <3B131E9E.70505@europe.com>
Date: Tue, 29 May 2001 04:59:26 +0100
From: Vasco Figueira <figueira@europe.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze for unknown reason
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri May 11 2001 - 13:45:24 EST, Vincent Stemen 
(linuxkernel@AdvancedResearch.org) wrote:

 >On Wednesday 09 May 2001 22:57, Jacky Liu wrote:

 >> The machine has been randomly lockup (totally freeze) for number of
 >> times without any traceable clue or error message. Usually the time
 >> frame between each lockup is between 24 to 72 hours. The screen just
 >> freeze when it's lockup (either in Console or X) and no "kernel >panic"
 >> type or any error message prompt up. All services (SSH, DNS, etc..)
 >> are dead when it's lockup
(...)

 >I have been experiencing these same problems since version 2.4.0.
 >Although, I think it has improved a little in 2.4.4, it still locks
 >up. The problem seems to be related to memory management and/or swap,
 >and is seems to do it primarily on machines with over 128Mb of RAM.
 >Although, I have not tested systematically enough to confirm this.

I have the same problem on a Toshiba satellite 4070, 366 celeron, 64M 
ram, redhat 7.1 and vanilla 2.4.5. Exactly the same bug description. 
Totally reproducible.

 >I have been monitoring the memory usage constantly with the gnome
 >memory usage meter and noticed that as swap grows it is never freed
 >back up. I can kill off most of the large applications, such as
 >netscape, xemacs, etc, and little or no memory and swap will be freed.
 >Once swap is full after a few days, my machine will lock up.

After a few *hours*.

Then I have (as you said) to do swapoff /dev/hda4 ; swapon -a in order 
to free the swap. If I do this, everything is fine... till it fills up 
again.

 >(...)I am
 >disappointed that we are now on the forth 2.4.x kernel version and
 >such as serious problem that has been there since 2.4.0 still exists.
 >This is pretty much a show stopper for having a production machine.

Totally agree. This is quite a showstopper. Do_try_to_free_pages, err... 
sorry, fix_bug.

Regards,

Vasco Figueira

