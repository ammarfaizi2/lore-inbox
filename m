Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131241AbRBPUlv>; Fri, 16 Feb 2001 15:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131240AbRBPUlb>; Fri, 16 Feb 2001 15:41:31 -0500
Received: from jkd.penguinfarm.com ([12.32.79.69]:23044 "HELO
	jkd.penguinfarm.com") by vger.kernel.org with SMTP
	id <S131241AbRBPUlX>; Fri, 16 Feb 2001 15:41:23 -0500
Message-ID: <3A8D9030.9040503@penguinfarm.com>
Date: Fri, 16 Feb 2001 15:40:16 -0500
From: Jason Straight <junfan@penguinfarm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: (2.4.1-ac15) pcmcia irq conflict
In-Reply-To: <E14TrL9-00043y-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any suggestions of things I could try to help pinpoint the problem and 
let you know the results? Everything was fine before 2.4.1.

I've been using the pcmcia-cs without kernel pcmcia support up until it 
didn't work with 2.4.1, then I tried using the kernel pcmcia and no deal 
there either.

As soon as I try to start pcmcia my machine freezes. When using 
yenta_socket I can see that the TI pcmcia and eth0 (intel eepro100) are 
both on irq 11.

when using the pcmcia-cs way of it I tried "exclude irq 11" in 
config.opts and /etc/sysconfig/pcmcia set "PCIC_OPTS="irq_list=9,10,15 
pci_irq_list=9,10,15"
as was suggested in this post :
http://groups.google.com/groups?q=inspiron+8000+pcmcia+2.4.1&hl=en&lr=&safe=off&rnum=1&seld=929215370&ic=1

It didn't work for me - at least not with 2.4.1-ac13 to ac15

I didn't disable my minipci ethernet because I need it and if the IRQ's 
for pcmcia didn't use 11 now I wouldn't think I would need to.




Alan Cox wrote:

>> I have a Dell Inspiron 8000. Trying to use pcmcia with kernel
>> (yenta_socket) or pcmcia-cs only causes pcmcia card to take irq 11,
>> which my eth device is on also. This didn't happen with 2.2 or 2.4.0
>> kernels.
> 
> 
> Sharing a PCI irq is legal, so that isnt the cause. It could be that the
> irq routing isnt getting handled correctly however. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Jason Straight

