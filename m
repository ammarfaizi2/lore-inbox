Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSK2P0f>; Fri, 29 Nov 2002 10:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267082AbSK2P0f>; Fri, 29 Nov 2002 10:26:35 -0500
Received: from [213.38.169.194] ([213.38.169.194]:14351 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S267081AbSK2P0e>; Fri, 29 Nov 2002 10:26:34 -0500
Message-ID: <0EBC45FCABFC95428EBFC3A51B368C9501B02D@jessica.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: "'Javier Marcet'" <jmarcet@pobox.com>, linux-kernel@vger.kernel.org
Subject: RE: Exaggerated swap usage
Date: Fri, 29 Nov 2002 15:28:30 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same thing happens with RedHat 8.0's latest 2.4.18-18 kernel.
Box has been up for almost 8 days.

top:

Mem:  1031036K av, 1021140K used,    9896K free,       0K shrd,   80560K
buff
Swap: 1052216K av,    5064K used, 1047152K free                  627808K
cached

vmstat:

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  0  0   5064  10192  80860 626932   0   0     2    21    3    56   0   0
36

Swapping in these circumstances shows a pathological reluctance to shed
cached pages.

Not critical, but hardly optimal behaviour.  Or is it?

Phil
---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: Javier Marcet [mailto:jmarcet@pobox.com]
> Sent: 29 November 2002 11:54
> To: linux-kernel@vger.kernel.org
> Subject: Exaggerated swap usage
> 
> 
> 
> Forgive me if I don't provide enough information just yet, or am not
> clear enough. I simply don't know what setting to tweak.
> 
> I'll explain.
> In recent 2.4.20 pre and rc kernels ( I tend to use the ac branch ), I
> had notice my system, when using X mainly, got terribly slow 
> after some
> use. It surprised me that when I tried 2.5.47 this did not happen at
> all, since I thought my problem was a lack of memory - the system has
> 384MB -.
> Hence I tried to find where the difference was. What I found is that
> 2.4.20 kernels - 2.4.19 does the same -, was swapping just too much,
> while there was a lot free memory on the system, cached but free.
> I disabled all swap and it suddenly began to work smoothly again, yet
> with the random kills when memory was a scarce resource on the system.
> I've tried different sysctl's vm.overcommit settings but the result is
> the same.
> 
> I also found a 2.4.x kernel which did not show this behavior, WOLK, in
> any version I tried.
> 
> Could you please point me toward something I can try tweaking, or some
> documentation to read which explains what I can change, 
> unless it's some
> kind of kernel problem?
> 
> BTW, aa kernels behaved somewhat better on this, only that 
> the last one
> I tried -rc2aa1- had some stability problems.
> 
> I can provide you with dmesg, /proc/meminfo or whatever might 
> be useful.
> 
> Thanks in advance :)
> 
> 
> -- 
> Javier Marcet <jmarcet@pobox.com>
> 
