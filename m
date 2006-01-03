Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWACTtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWACTtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWACTtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:49:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54722 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932508AbWACTtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:49:40 -0500
Date: Tue, 3 Jan 2006 20:49:33 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matan Peled <chaosite@gmail.com>
cc: linux-kernel@vger.kernel.org, kwall@kurtwerks.com
Subject: Re: Arjan's noinline Patch
In-Reply-To: <43B98CAC.6060801@gmail.com>
Message-ID: <Pine.LNX.4.61.0601032036090.11129@yvahk01.tjqt.qr>
References: <20060101155710.GA5213@kurtwerks.com> <20060102034350.GD5213@kurtwerks.com>
 <43B8FA70.2090408@gmail.com> <Pine.LNX.4.61.0601021949240.29938@yvahk01.tjqt.qr>
 <43B98CAC.6060801@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> size:
>>    text    data     bss      dec     hex filename
>> 17188479 5984442 1738248 24911169 17c1d41 rc7-noinl-Os/vmlinux
>> 17313751 5980978 1738248 25032977 17df911 rc7-Os/vmlinux
>> 20174873 5991726 1738248 27904847 1a9cb4f rc7-noinl/vmlinux
>> 20222221 5992278 1738248 27952747 1aa866b rc7-NFI/vmlinux
>> 20321527 5988706 1738248 28048481 1abfc61 rc7-std/vmlinux
>
> Just out of pure curiosity... Where would NFI-Os stand?
>
> one would expect it to be around 17225???...

  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/i386/kernel/built-in.o: In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/i386/kernel/built-in.o: In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/i386/kernel/built-in.o: In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/i386/kernel/built-in.o: In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/i386/kernel/built-in.o:: more undefined references to 
`__this_fixmap_does_not_exist' follow
make: *** [.tmp_vmlinux1] Error 1

I hacked it up a little to get a result so...
   text    data     bss     dec     hex filename
17286376        4281178 1738248 23305802        1639e4a .tmp_vmlinux1



Jan Engelhardt
-- 
