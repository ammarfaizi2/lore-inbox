Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbULPQhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbULPQhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbULPQhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:37:12 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55680 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261431AbULPQhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:37:04 -0500
Message-ID: <41C1B9A8.2020003@nortelnetworks.com>
Date: Thu, 16 Dec 2004 10:36:56 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Ross <chris@tebibyte.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: slow OOM killing with 2.6.9?
References: <41C065A2.4040504@nortelnetworks.com> <41C1777A.3080105@tebibyte.org>
In-Reply-To: <41C1777A.3080105@tebibyte.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> 
> Chris Friesen escreveu:
> 
>> I've got a ppc box with 2GB of ram, running 2.6.9.
>>
>> If I run a few instances of memory chewing programs, eventually the 
>> OOM-killer kicks in.  At that point, the machine locks up for about 10 
>> seconds while deciding what to kill.
> 
> 
> OOM killing is known to be broken in 2.6.9, specifically it kills things 
> even when the machine isn't out of memeory and/or kills the "wrong" 
> things when it is. See threads assim for more details.
> 
> The OOM Killer is working properly again in 2.6.10-rc2-mm4. Could you 
> try that kernel and report whether it fixed your problems too?

Hmm...downloaded 2.6.9, patched to 2.6.10-rc2, patched to 2.6.10-rc2-mm4.  Tried 
building and got the following error:

[cfriesen@hsdbsk204-83-218-112 linux-2.6.10-rc2-mm4]$ make
   CHK     include/linux/version.h
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/ppc/mm/built-in.o(.init.text+0x5f4): In function `paging_init':
: undefined reference to `pgd_offset_is_obsolete'
make: *** [.tmp_vmlinux1] Error 1

Any ideas?

Chris
