Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265293AbSKFOST>; Wed, 6 Nov 2002 09:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265365AbSKFOST>; Wed, 6 Nov 2002 09:18:19 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:51727 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S265293AbSKFOSS>; Wed, 6 Nov 2002 09:18:18 -0500
Message-ID: <3DC9252A.6080205@convergence.de>
Date: Wed, 06 Nov 2002 15:20:26 +0100
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb@linuxtv.org
Subject: Re: 2.5.46: DVB don't work...
References: <20021105163106.GA5169@ulima.unil.ch> 	<20021106112353.GA22269@ulima.unil.ch> <1036589313.9781.10.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-11-06 at 11:23, Gregoire Favre wrote:
> 
>>On Tue, Nov 05, 2002 at 05:31:06PM +0100, Gregoire Favre wrote:
>>
>>I have tried to compil dvb-ttpci in the kernel:
>>
>>  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
>>drivers/built-in.o(.data+0xf6f4): undefined reference to `local symbols in discarded section .exit.text'
>>make: *** [.tmp_vmlinux1] Error 1
>>
>>Anyone got a fix?
> 
> 
> Missing devexit_p for the pci remove call somewhere. I'll take a look if
> I get time, but you are looking for a pci module declaration which has a
> remove function that isnt marked __devexit_p() when the function it
> calls is
> 

I'll fix this in the linux-dvb CVS repository, it will be included in 
the next 2.5 patchset.

Holger


