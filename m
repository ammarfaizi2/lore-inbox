Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265897AbSKBIol>; Sat, 2 Nov 2002 03:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSKBIok>; Sat, 2 Nov 2002 03:44:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34313 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265897AbSKBIok>; Sat, 2 Nov 2002 03:44:40 -0500
Message-ID: <3DC391D3.7040005@zytor.com>
Date: Sat, 02 Nov 2002 00:50:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Aaron Lehmann <aaronl@vitelus.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, viro@math.psu.edu
Subject: Re: [BK PATCHES] initramfs merge, part 1 of N
References: <3DC38939.90001@pobox.com> <20021102084226.GA7800@vitelus.com> <3DC390F2.6040600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Aaron Lehmann wrote:
> 
>> On Sat, Nov 02, 2002 at 03:13:45AM -0500, Jeff Garzik wrote:
>>  
>>
>>> The Future.
>>>
>>> Early userspace is going to be merged in a series of evolutionary 
>>> changes, following what I call "The Al Viro model."  NO KERNEL 
>>> BEHAVIOR SHOULD CHANGE.  [that's for the lkml listeners, not you 
>>> <g>]  "make" will continue to simply Do The Right Thing(tm) on all 
>>> platforms, while the kernel image continues to get progressively 
>>> smaller.
>>>   
>>
>>
>> Won't the initial userspace be linked into the kernel? If so, why will
>> the kernel image get smaller?
>>  
>>
> 
> Yes and no ;-)
> 
> Ignoring for a moment initramfses loaded from your bootloader (a la 
> initrd)...   The amount of code that runs in kernel space shrinks, which 
> is the main point of early userspace.  If you are talking in terms of 
> overall kernel image size, yes, but the initramfs cpio archive is 
> ditching along with the rest of __init code, so you're really only 
> talking about wasting a couple of additional pages in vmlinux -- a 
> slight increase in disk space usage, and that's it.
> 
> So runtime memory usage certainly does not increase...
> 

By the way, the final initramfs should typically be a union of whatever 
sources there are; with the ones linked into the kernel image unpacked 
first (so they can be overwritten if so specified to the bootloader.)

	-hpa


