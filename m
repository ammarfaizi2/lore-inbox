Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSJ3IgA>; Wed, 30 Oct 2002 03:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSJ3IgA>; Wed, 30 Oct 2002 03:36:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11793 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264622AbSJ3If6>;
	Wed, 30 Oct 2002 03:35:58 -0500
Message-ID: <3DBF9B4D.8020205@pobox.com>
Date: Wed, 30 Oct 2002 03:41:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: landley@trommello.org, linux-kernel@vger.kernel.org, reiser@namesys.com,
       alan@lxorguk.ukuu.org.uk, davem@redhat.com, boissiere@adiglobal.com
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <200210300229.44865.dcinege@psychosis.com> <3DBF8CD5.1030306@pobox.com> <200210300322.17933.dcinege@psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

>On Wednesday 30 October 2002 2:40, Jeff Garzik wrote:
>
>  
>
>>untar - cpio is better.
>>    
>>
>
>CPIO is commonly used and supported by NO ONE. (rpm, whoppee)
>Kernels even come tar'ed. KISS....
>
Irrelevant to this problem.  cpio unpack code is smaller, and its format 
allows easy and painless concatenation.

>>initrd - 99% moved out of the kernel
>>    
>>
>
>Great...you just killed the high level embedded linux market, and
>the ability to play boot games from GRUB. (Network, etc)
>Initrd is a good **OPTION* to have to fall back on...
>
Correct -- and after the initramfs merge, initrd behavior will be 
completely unchanged.

>>do_mounts - moved out of the kernel completely
>>    
>>
>
>And he's willing to completely purge initrd and do_mounts NOW???
>
Nothing is being purged.  Things are being moved to userspace, making 
the kernel smaller and less bloated.  The kernel's behavior to the end 
user is 100% unchanged.

>>initramfs - should be ready for Linus in the next day or so.
>>    
>>
>
>Fire away with the 100K+ bloated POS. I'm backwards compatible,
>could easily add 'linked kernel image' support, and only increase
>the current code by 20K.
>
initramfs decreases the kernel size by a load, thank you very much.

Further, any initrd solution is bloated -- you are using a ram disk and 
disk-based filesystem, the sum of which equates to ramfs -- with 
additional wasted memory for filesystem and ramdisk overhead.

    Jeff




