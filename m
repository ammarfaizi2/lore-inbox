Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273793AbRIRAb2>; Mon, 17 Sep 2001 20:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273794AbRIRAbS>; Mon, 17 Sep 2001 20:31:18 -0400
Received: from lego.zianet.com ([204.134.124.54]:3333 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S273793AbRIRAbA>;
	Mon, 17 Sep 2001 20:31:00 -0400
Message-ID: <3BA694CB.8020500@zianet.com>
Date: Mon, 17 Sep 2001 18:26:51 -0600
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010910
X-Accept-Language: en-us
MIME-Version: 1.0
To: Adam Radford <aradford@3WARE.com>
CC: linux-kernel@vger.kernel.org, Linux <linux@3WARE.com>
Subject: Re: 3ware raid oops
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EAEBA@siamese>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh, I knew I forgot something, kernel version would
help.  It is 2.4.9.

I am running version 1.02.00.007 so i guess it is
that printk.  I have since added drives to it and have
had no more problems so I will just wait till 2.4.10
comes out.

Thanks.

Adam Radford wrote:

> Steve,
>
> What version of the driver are you running? 
>
> If you are running an older driver, then this is a small printk
> error.  Try running the driver v1.02.00.008 in 2.4.10-pre10
>
> Also, it would help if you mentioned the exact kernel version
> you are running.
>
> Thanks.
>
> --
> Adam Radford
> Software Engineer
> 3ware, Inc.
>
> -----Original Message-----
> From: Steven Spence [ mailto:kwijibo@zianet.com ]
> Sent: Saturday, September 15, 2001 8:36 AM
> To: Steven Spence
> Cc: linux-kernel@vger.kernel.org; linux@3ware.com
> Subject: Re: 3ware raid oops
>
>
> Woops, I had the wrong system map when I rand that ksymoops,
> here is right one. Sorry bout that.
>
> Steve
>
>  >>EIP; c01e69aa <tw_aen_drain_queue+5a/320>   <=====
> Trace; c01e71dc <tw_findcards+11c/410>
> Trace; c0105000 <_stext+0/0>
> Trace; c01c3135 <scsi_register_host+55/2f0>
> Trace; c0105000 <_stext+0/0>
> Trace; c0151eaf <proc_register+f/90>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105098 <init+28/190>
> Trace; c0105000 <_stext+0/0>
> Trace; c01055f6 <kernel_thread+26/30>
> Trace; c0105070 <init+0/190>
> Code;  c01e69aa <tw_aen_drain_queue+5a/320>
> 00000000 <_EIP>:
> Code;  c01e69aa <tw_aen_drain_queue+5a/320>   <=====
>    0:   0f b7 40 36               movzwl 0x36(%eax),%eax   <=====
> Code;  c01e69ae <tw_aen_drain_queue+5e/320>
>    4:   50                        push   %eax
> Code;  c01e69af <tw_aen_drain_queue+5f/320>
>    5:   68 00 b5 27 c0            push   $0xc027b500
> Code;  c01e69b4 <tw_aen_drain_queue+64/320>
>    a:   e8 d7 f2 f2 ff            call   fff2f2e6 <_EIP+0xfff2f2e6>
> c0115c90 <printk+0/1a0>
> Code;  c01e69b9 <tw_aen_drain_queue+69/320>
>    f:   5a                        pop    %edx
> Code;  c01e69ba <tw_aen_drain_queue+6a/320>
>   10:   b8 01 00 00 00            mov    $0x1,%eax
>
> Steven Spence wrote:
>
> > I received a kernel oops on bootup from the 3ware raid drivers.
> > It was detecting the card when it oopsed.  Atm I do not have any
> > hard drives connected to it so it doesn't find anything, that may
> > be the problem.  The card is a 3ware Escalade 7410 and the computer
> > is a dual Athlon, if any more info needed bout hardware let me know.
> > Here is oops and ksymoops(default options), btw I had to hand write
> > the oops so I hope I did not make any mistakes.
> >
> > Steve
> >
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000036
> >
> > Printing eip
> > c01e69aa
> > Oops:0000
> > CPU: 1
> > EIP: 0010:[<c01e69aa>]
> > EFLAGS: 00010002
> >
> > eax: 00000000   ebx: 00000000  ecx: 00040000   edx: c028cc60
> > esi: f7d55c00   edi: f7d55c00  ebp: f7d55cc00   esp: c21157ef0
> > ds: 0018   es: 0018  ss: 0018
> >
> > Stack: f7d55c00  00000082  00000000  00000000  00000000  00001c3c 
> > 00001c34  00001c38
> >       000a2378  00000000  00000000  f7d55c00  f7d55c00  f7dfc800 
> > c01e7adc  f7d55c00
> >       f7d55c00  c2115f44  00000001  00000000  00000000  10011000 
> > 01000292  00000000
> >
> > Call Trace: [<c01e71dc>] [<c0105000>] [<c01c3135>] [<c0105000>]
> > [<c0151eaf>]
> >            [<c0105000>] [<c0105098>] [<c0105000>] [<c01055f6>]
> > [<c0105070>]
> >
> > >>EIP; c01e69aa <scsi_free+1c21a/28930>   <=====
> > Trace; c01e71dc <scsi_free+1ca4c/28930>
> > Trace; c0105000 <gdt+4d94/4f94>
> > Trace; c01c3135 <scsi_do_cmd+b95/1580>
> > Trace; c0105000 <gdt+4d94/4f94>
> > Trace; c0151eaf <kiobuf_wait_for_io+5b9f/5d90>
> > Trace; c0105000 <gdt+4d94/4f94>
> > Trace; c0105098 <gdt+4e2c/4f94>
> > Trace; c0105000 <gdt+4d94/4f94>
> > Trace; c01055f6 <kernel_thread+26/1e0>
> > Trace; c0105070 <gdt+4e04/4f94>
> > Code;  c01e69aa <scsi_free+1c21a/28930>
> > 00000000 <_EIP>:
> > Code;  c01e69aa <scsi_free+1c21a/28930>   <=====
> >   0:   0f b7 40 36               movzwl 0x36(%eax),%eax   <=====
> > Code;  c01e69ae <scsi_free+1c21e/28930>
> >   4:   50                        push   %eax
> > Code;  c01e69af <scsi_free+1c21f/28930>
> >   5:   68 00 b5 27 c0            push   $0xc027b500
> > Code;  c01e69b4 <scsi_free+1c224/28930>
> >   a:   e8 d7 f2 f2 ff            call   fff2f2e6 <_EIP+0xfff2f2e6>
> > c0115c90 <printk+0/1a0>
> > Code;  c01e69b9 <scsi_free+1c229/28930>
> >   f:   5a                        pop    %edx
> > Code;  c01e69ba <scsi_free+1c22a/28930>
> >  10:   b8 01 00 00 00            mov    $0x1,%eax
> >
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>



