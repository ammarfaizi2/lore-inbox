Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279598AbRJXVJF>; Wed, 24 Oct 2001 17:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279600AbRJXVIz>; Wed, 24 Oct 2001 17:08:55 -0400
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:41746 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S279598AbRJXVIg>; Wed, 24 Oct 2001 17:08:36 -0400
Message-ID: <3BD72D5C.30604@ndsu.nodak.edu>
Date: Wed, 24 Oct 2001 16:06:36 -0500
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011018
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be> <3BD532EC.6080803@eisenstein.dk> <20011023130756.A742@cy599856-a.home.com> <20011024005107.A3988@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon wrote:

> The first thing I did was to kach the horrible nVidia's Makefile. For example,
> it had the bad intention of compiling and installing against the running kernel
> (guess kernel with uname -r). So when you update the kernel, you have to reboot
> and make nVidia drivers. I changed it to:
> 
> +KREL:=`grep UTS_RELEASE /usr/src/linux/include/linux/version.h | cut -d\" -f2`
> -KERNDIR:=/lib/modules/$(shell uname -r)
> +KERNDIR:=/lib/modules/$(KREL)
> 
> so it builds against a built but not-running kernel.
> 
> 

I thought use of /usr/src/linux was not recommended anymore. On my 
distro, that file would point to the original kernel, the one that 
glibc, et al. is compiled with, not my current running kernel or ones 
I've not yet booted with. Perhaps a `uname -r` with command-line 
override would be more appropriate?

Regards,
Reid

