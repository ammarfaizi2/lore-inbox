Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUFRA1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUFRA1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 20:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUFRA1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 20:27:52 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42893 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264843AbUFRA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 20:27:47 -0400
Message-ID: <40D23701.1030302@opensound.com>
Date: Thu, 17 Jun 2004 17:27:45 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
In-Reply-To: <3217460000.1087518092@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>I am writing this message to bring a huge problem to light. SuSE has been systematically
>>forking the linux kernel and shipping all kinds of modifications and still call their
>>kernels 2.6.5 (for example).
>>
>>Either they ship the stock Linux kernel sources or they stop calling their distributions
>>as Linux-2.6.x based.
> 
> 
> Umm. They said they're linux-2.6.x based ... ie they're BASED on 2.6,
> not identical. No major vendor ships completely virgin source.
>  
> 
>>Kernel headers are being changed willy-nilly and SuSE are completely running rough-shod
>>over the linux kernel with the result ONLY software from SuSE works.
> 
> 
> I think you're getting somewhat carried away. Yes, there are lots of mods.
> Most of them are merged back into mainline already (as of 2.6.7).
>  
> 
>>This is absolutely not our problem and we don't know who to contact at SuSE to fix
>>this problem. Our software works perfectly with Fedora/Debian/Gentoo/Mandrake/Redhat/etc.
> 
> 
> So what's broken then? Specifically which kernel interface are you 
> calling that has a broken behaviour?
> 
> 
>>I think SuSE's lying when they call their Linux kernel a 2.6.5 kernel 
>>when there are massive differences. 
> 
> 
> They didn't say it was 2.6.5, they said it was based on it.
> 
> 
>>They aren't even compatible with Linux 2.6.6.
> 
> 
> In what way?
>  
> 
>>I urge all those who have the power to sway distributions to 
>>immediately fix their kernels so that small developers like us don't 
>>have to keep updating our software.
> 
> 
> I'd be more inclined to suspect you're relying on some behaviour that isn't
> really defined ...
> 
> And no, I don't work for SuSE.
> 
> M.
> 
> 


Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
they have gone and changed the kernel headers which mean that nothing works.

For instance our kernel interface module doesn't compile anymore we see the following
errors:

> make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
> make[1]: Entering directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> make[1]: Nothing to be done for `scripts'.
> make[1]: *** No rule to make target `scripts_basic'.  Stop.
> make[1]: Leaving directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> make: *** [ossbuild] Error 2
>  
> Trying to compile using INCLUDE=/lib/modules/2.6.5-7.75-bigsmp/build/include
> In file included from /usr/include/asm/smp.h:18,
>                  from /usr/include/linux/smp.h:17,
>                  from /usr/include/linux/sched.h:23,
>                  from /usr/include/linux/module.h:10,
>                  from src/sndshield.c:49:
> /usr/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
> In file included from /usr/include/asm/smp.h:18,
>                  from /usr/include/linux/smp.h:17,
>                  from /usr/include/linux/sched.h:23,
>                  from /usr/include/linux/module.h:10,



Why is this happening?. It's working fine with Linux 2.6.5 and also worked with
Linux 2.6.4 kernels from SuSE 9.1


best regards
Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

