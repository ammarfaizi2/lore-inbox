Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131242AbRCHA4B>; Wed, 7 Mar 2001 19:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbRCHAzw>; Wed, 7 Mar 2001 19:55:52 -0500
Received: from [216.161.55.93] ([216.161.55.93]:3316 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131255AbRCHAzi>;
	Wed, 7 Mar 2001 19:55:38 -0500
Date: Wed, 7 Mar 2001 16:59:55 -0800
From: Greg KH <greg@wirex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac14
Message-ID: <20010307165955.C788@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010307164052.B788@wirex.com>; from greg@wirex.com on Wed, Mar 07, 2001 at 04:40:52PM -0800
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 04:40:52PM -0800, Greg KH wrote:
> On Wed, Mar 07, 2001 at 11:13:37PM +0000, Alan Cox wrote:
> > o	Fix the non build problem with do_BUG		(Andrew Morton)
> 
> gcc -D__KERNEL__ -I/home/greg/linux/linux-2.4.2-ac14/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -march=i686  -mno-terminator-canary    -DEXPORT_SYMTAB -c i386_ksyms.c
> i386_ksyms.c:170: `do_BUG' undeclared here (not in a function)
> i386_ksyms.c:170: initializer element for `__ksymtab_do_BUG.value' is not constant
> make[1]: *** [i386_ksyms.o] Error 1
> make[1]: Leaving directory
> `/home/greg/linux/linux-2.4.2-ac14/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2
> 
> .config attached

Enabling CONFIG_DEBUG_BUGVERBOSE allows the build to work.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
