Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTBUWTm>; Fri, 21 Feb 2003 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTBUWTm>; Fri, 21 Feb 2003 17:19:42 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:21219 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267736AbTBUWTl>; Fri, 21 Feb 2003 17:19:41 -0500
Message-Id: <200302212229.XAA00840@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: ioctl32 consolidation
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 21 Feb 2003 23:27:24 +0100
References: <20030221114011$5b98@gated-at.bofh.it> <20030221114011$7728@gated-at.bofh.it> <20030221114011$25df@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>> I do not know if it is too late in 2.5.x to begin this work, however.
>> We _are_ in a feature freeze...  I suppose it is up to the consensus of
>> arch maintainers, because it [obviously] does not affect ia32.
> 
> Actually Andi asked me to do the work. Dave, is it okay with you? What
> about other maintainers?

For s390, I'd love to see progress in the consolidation. Feel free to
submit changes for arch/s390x/kernel/ioctl32.c directly, like 
Stephen Rothwell does for the syscall32 consolidation. Of course,
Martin has the last word here, but I'm rather sure he agress with me
in this.

If you want access to an s390x system, you can probably get access
to one at http://www-1.ibm.com/servers/eserver/zseries/os/linux/lcds/ 
or install the hercules emulator. I try to keep working kernel tree
at http://linux-390.bkbits.net/, but the 32 bit emulation has been
broken for most of 2.5.

Note that for any ioctls that pass pointers, you will need special
massaging for the high order bit of the user space pointer, because
s390 only has 31 bit pointers, not 32 bit.

        Arnd <><
