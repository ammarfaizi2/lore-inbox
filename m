Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291171AbSBSLDo>; Tue, 19 Feb 2002 06:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291162AbSBSLDf>; Tue, 19 Feb 2002 06:03:35 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:921 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S291161AbSBSLDY>; Tue, 19 Feb 2002 06:03:24 -0500
Subject: Re: Q: use of new modules in old kernel
From: NyQuist <NyQuist@ntlworld.com>
To: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020219090253.CD89D67ED@penelope.materna.de>
In-Reply-To: <20020219090253.CD89D67ED@penelope.materna.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 10:53:57 +0000
Message-Id: <1014116037.2019.7.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-19 at 09:02, Tobias Wollgam wrote:
> Hi,
> 
> how is it possible to use modules of newer kernels in an old kernel 
> system?
> 
> To use new drivers, we want not recompile the kernel.
> 
> I tried to load the module 8139too from 2.4.17 into a 2.4.9 kernel with 
> modprobe, but there are many unresolved symbols. 
> 
> The flag "Set version information on all module symbols" is set.
> 
> TIA for all information, hyperlinks are welcome too,
> 
> 	Tobias
> 

<short version>
What worked for me (see later), is moving the newer module and
appropriate includes across to the older kernel and performing a make
modules && make modules_install. 

<long version>
This worked for me when using a patched nm256_audio and ac97 module to
get my sound working. I couldn't get the patch to apply properly to the
whole kernel, so I nicked those files I knew were needed and moved them
over to a clean kernel. hope this helps, and yeh, I've got no idea if
this will work for you. I would first try copying the 8139too.c from
drivers/net to the 2.4.9 kernel, and if you've already setup your config
you should just be able to make modules and then insmod (with luck).
> -- 
> Tobias Wollgam * Softwaredevelopment * Business Unit Information 
> MATERNA GmbH Information & Communications
> Vosskuhle 37 * 44141 Dortmund  
> http://www.materna.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
NyQuist | Matthew Hall -- NyQuist at ntlworld dot com 
Sig: Microsoft sells you Windows. Linux gives you the whole house.

