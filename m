Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSCUQiC>; Thu, 21 Mar 2002 11:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSCUQhs>; Thu, 21 Mar 2002 11:37:48 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:47876
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S312248AbSCUQhD>; Thu, 21 Mar 2002 11:37:03 -0500
Message-ID: <3C9A0C22.3090702@inet6.fr>
Date: Thu, 21 Mar 2002 17:36:50 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020307
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nicholas black <dank@trellisinc.com>
CC: linux-kernel@vger.kernel.org, marcelo@connectiva.com.br
Subject: Re: sis 5591 ide in 2.4.19-pre3 consumes souls
In-Reply-To: <20020321110412.A6558@fancypants.trellisinc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nicholas black wrote:

>yesterday night i excitedly came home to my shiny new -pre3, to discover
>that on boot, all ide devices timeout on DMA requests.  i'm using the
>sis ide driver on my sis 5591 controller, which is integrated onto an
>amptron 810 motherboard.  
>

There's definitely a problem with some UDMA 33 chipsets. I'll ask SiS 
for 5591 chipset info RSN and look into this as soon as I find some time.

>
>i haven't had a chance to capture exact logs yet, but can do testing
>tonight.  exact behavior follows:
>
>rebooted with 2.4.19-pre3-jl11 (preemptive; jl11 is a patch to
>networking code that should play no role here).  hard drive hda and
>cdrom's hdc,hdd are detected.  upon partition check of hda1, the system
>hung for roughly 20 seconds, after which it was declared dma commands
>had timed out.  this was repeated for all other partitions on the drive,
>after which the kernel panicked, unable to mount the root fs.
>
>this behavior continued to manifest over any number of reboots.
>interestingly, i could get my old 2.4.18-jl11 (non-preempt) to work
>fine, but only after a hard power down.  reboots left it in the same
>situation, but not logging nearly so much to the console :).
>
Could you send us the output of "lspci -vxxx" with 2.4.18-jl11 and boot 
logs of 2.4.19-pre3-jl11 please ?

Did you "make oldconfig" on the 2.4.19-pre3-jl11 sources with the your 
old 2.4.18-jl11 .config or made a new config from scratch ?
If so assuming you didn't modify your source trees could you send us the 
result of :
diff <2.4.18-jl11_tree>/.config <2.4.19-pre3-jl11_tree>/.config | grep  
"^. CONFIG"

LB.

