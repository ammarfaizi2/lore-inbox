Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265896AbSKBIlB>; Sat, 2 Nov 2002 03:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265897AbSKBIlB>; Sat, 2 Nov 2002 03:41:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265896AbSKBIlA>;
	Sat, 2 Nov 2002 03:41:00 -0500
Message-ID: <3DC390F2.6040600@pobox.com>
Date: Sat, 02 Nov 2002 03:46:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, hpa@zytor.com, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
References: <3DC38939.90001@pobox.com> <20021102084226.GA7800@vitelus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:

>On Sat, Nov 02, 2002 at 03:13:45AM -0500, Jeff Garzik wrote:
>  
>
>>The Future.
>>
>>Early userspace is going to be merged in a series of evolutionary 
>>changes, following what I call "The Al Viro model."  NO KERNEL BEHAVIOR 
>>SHOULD CHANGE.  [that's for the lkml listeners, not you <g>]  "make" 
>>will continue to simply Do The Right Thing(tm) on all platforms, while 
>>the kernel image continues to get progressively smaller.
>>    
>>
>
>Won't the initial userspace be linked into the kernel? If so, why will
>the kernel image get smaller?
>  
>

Yes and no ;-)

Ignoring for a moment initramfses loaded from your bootloader (a la 
initrd)...   The amount of code that runs in kernel space shrinks, which 
is the main point of early userspace.  If you are talking in terms of 
overall kernel image size, yes, but the initramfs cpio archive is 
ditching along with the rest of __init code, so you're really only 
talking about wasting a couple of additional pages in vmlinux -- a 
slight increase in disk space usage, and that's it.

So runtime memory usage certainly does not increase...

    Jeff




