Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135919AbRDZVBq>; Thu, 26 Apr 2001 17:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135935AbRDZVAy>; Thu, 26 Apr 2001 17:00:54 -0400
Received: from zeus.kernel.org ([209.10.41.242]:128 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135931AbRDZU7z>;
	Thu, 26 Apr 2001 16:59:55 -0400
From: Josh McKinney <forming@home.com>
Date: Thu, 26 Apr 2001 15:16:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: About rebuild 2.4.x kernel to support SMP.
Message-ID: <20010426151615.A19046@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56A@EXCHANGE2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56A@EXCHANGE2>; from YipingChen@via.com.tw on Thu, Apr 26, 2001 at 10:59:44PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that you never installed the new kernel.  Try 'make install'
or manually cp'ing the vmlinuz and system.map yourself.

On approximately Thu, Apr 26, 2001 at 10:59:44PM +0800, Yiping Chen wrote:
> 
> I know it's not proper ask such question here. But I don't know where can I
> post this question.
> I download RedHat 7.1 last week, and install it in my dual-CPU enviroment.
> I try to rebuild kernel that support SMP in kernel 2.4.2 today , but it
> failed.
> The following is what I did.
> ========================================
> 1. Install Red Hat 7.1 in my dual-CPU environment
> 2. type 'uname -a' , the following is the result:
>     Linux lab5-1 2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686 unknown
> 3. cd /usr/src/linux-2.4 (becuase Red Hat link the 2.4.2 kernel source to
> linux-2.4)
> 4. make mrproper
> 5. make menuconfig (set SMP and RTC)
> 6. make dep
> 7. make clean
> 8. make bzImage
> 9. make modules
> 10. make modules_install
> 11. edit /etc/lilo.conf
> 12. run lilo
> 13. reboot, choose new kernel to boot the system, type 'uname -a'
>      Linux lab5-1 2.4.2-2 #1 SMP Wed Apr 25 18:56:05 CST 2001 i686 unknown
> 
> My question is why the result of 'uname -r' is not "2.4.2-2smp" , but
> "2.4.2-2"
> Whether I forgot to do something?
> It seems that when we compile the 2.4.2 kernel, it will not use -D__SMP__
> argument now.
> (because I didn't see it in /usr/src/linux-2.4/Makefile, and I didn't see it
> when I did 'make bzImage')
> If someone ever build 2.4.x kernel which support SMP, please teach me how to
> do it.
> Thanks!!
> 
> --------------------------------------------------
> Yiping Chen
> VIA Technologies, Inc.
> LAN Software
> 533 Chung Cheng Road 8F
> Hsin Tien, Taipei
> Taiwan
> TEL : 886-2-22185452  EXT.7512
> FAX : 886-2-22187527
> E-mail : YipingChen@via.com.tw
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Linux, the choice          | There was a young man from Stamboul Who
of a GNU generation   -o)  | boasted so torrid a tool  That each female 
Kernel 2.4.3-ac1       /\  | crater  Explored by this satyr Seemed
on a i586             _\_v | almost unpleasantly cool. 
                           | 
