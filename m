Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275308AbTHMTgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275328AbTHMTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:36:08 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:18584 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S275308AbTHMTgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:36:04 -0400
Message-ID: <3F3A9302.5000806@home.ro>
Date: Wed, 13 Aug 2003 22:35:30 +0300
From: Nufarul Alb <nufarul.alb@home.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Carter <jimc@math.ucla.edu>, linux-kernel@vger.kernel.org
Subject: Re: multibooting the linux kernel
References: <3F396C04.90608@home.ro> <20030813072053.A25803@infradead.org> <3F3A2DB9.7030601@home.ro> <Pine.LNX.4.53.0308130904140.3016@xena.cft.ca.us>
In-Reply-To: <Pine.LNX.4.53.0308130904140.3016@xena.cft.ca.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Carter wrote:

>On Wed, 13 Aug 2003, Nufarul Alb wrote:
>  
>
>>>>There is a patch for the kernel that make it able to preload modules
>>>>before the acutal booting.
>>>>        
>>>>
>
>Perhaps I'm misunderstanding the issue, but this sounds like a job for
>initrd.  Someone jokingly mentioned booting wirelessly through a
>cipe pipe, so you would stick iwconfig and cipe (and your RAID driver and
>all the other wierd stuff) in the initrd.  A lot of distros do this for you
>automatically, including SuSE.
>
>So how are the kernel and initrd images read?  Grub has drivers for a fair
>number of devices, and can read i86 BIOS-supported discs, conventional
>Ethernet, some RAID (I think), etc.  You can't load modules from your
>regular filesystem until you can read your filesystem, meaning that the
>module used to read your filesystem has to be provided by some other means.
>Like initrd.
>
>Hope this helps rather than smokes up the issue.
>
>James F. Carter          Voice 310 825 2897    FAX 310 206 6673
>UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
>Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
>
>  
>
the use of initrd is a real pain in the butt. with multibooting GRUB 
loads the modules into memory and the kernel can take them from there. 
In this way the main kernel can be smaller, you won't need built-in 
filesystem drivers  (they will be preloaded by GRUB), you will not have 
to recompile the entire kernel all the time, but only the modules.

The MAIN THING  that a multiboot kernel will solve is the problem of 
module portability. I think that the reason why hardware producers are 
not making drivers for linux is that they have to make them open source 
in order to be compiled by every user. With multibooting it become 
possible to make a standard type of the main image of the kernel and all 
the modules will be built for it. So, the hardware vendors won't have to 
make public their sources and they will be encouraged to write drivers.

AND besides all that you can do many operations before mounting the 
actual root like, for example, make a module that encapsulates a nice 
boot animation, a progress bar, show the services start in a nice 
graphical way on top of the framebuffer.Of course this can be done with 
the current kernel, but you have to rebuild the entire kernel each time, 
errors will appear all the time.



