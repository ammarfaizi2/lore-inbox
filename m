Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313346AbSDYUKc>; Thu, 25 Apr 2002 16:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313384AbSDYUKb>; Thu, 25 Apr 2002 16:10:31 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:22720 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S313346AbSDYUKa>; Thu, 25 Apr 2002 16:10:30 -0400
Message-ID: <3CC861CA.3040104@linuxhq.com>
Date: Thu, 25 Apr 2002 16:06:34 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darrel Hunt <darrelhu@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: Upgrading Kernel
In-Reply-To: <ucf0d9ilcjqge3@corp.supernews.com> <3CC845EA.6060405@linuxhq.com> <000201c1ec89$21025440$0400a8c0@famas>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this for real?  comx.o has been broken since 2.4.0 it seems!
Anyone know anything about these modules?

Darrel, these errors are caused because (though the modules compile) 
they are making references to functions that no longer exist in the 
kernel.  My advice is that (unless you really need to use these modules) 
you configure your kernel to not include them.

Darrel Hunt wrote:
> Thanks, that helped alot.  Now I'm running into another small problem, 
> I've done it just as you listed.  Everything goes good unitll I go to 
> "make modules_install".  The problem is that it halts with this description.
> 
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18/kernel/drivers/telephony/ixj_pcmcia.o
> depmod:         register_pccard_driver
> depmod:         unregister_pccard_driver
> depmod:         CardService
>  > cp /usr/src/linux-2.4.5/.config /usr/src/linux-2.4.18/.config
>  > cd /usr/src/linux-2.4.18
>  > make oldconfig
>  > make dep
>  > make bzImage
>  > make modules
>  > make modules_install
>  >
>  > cp /usr/src/linux-2.4.18/arch/i386/boot/bzImage /boot/vmlinuz-2.4.18
>  >
>  > Then edit your /etc/lilo.conf, and add an entry for your new kernel.
>  >
>  > Run "lilo"
>  >
>  > Reboot.
>  >
>  > Hope this helps.
>  >



