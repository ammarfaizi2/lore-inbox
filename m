Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267171AbSKSUld>; Tue, 19 Nov 2002 15:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbSKSUld>; Tue, 19 Nov 2002 15:41:33 -0500
Received: from www.txcdc.com ([65.67.58.21]:37776 "HELO escalade.vistahp.com")
	by vger.kernel.org with SMTP id <S267171AbSKSUlO>;
	Tue, 19 Nov 2002 15:41:14 -0500
Message-ID: <20021119205154.9616.qmail@escalade.vistahp.com>
References: <20021119201110.GA11192@mars.ravnborg.org>
In-Reply-To: <20021119201110.GA11192@mars.ravnborg.org>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Separate obj/src dir
Date: Tue, 19 Nov 2002 14:51:54 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg writes: 

<snip>
> Another drawback is that when a .h file exist in the
> SRCTREE but not in the OBJTREE the generated dependencies
> will point out the .h file located in SRCTREE.
> This happens for generated .h files, and therefore a simple
> check is made in kbuild to check that the SRCTREE is
> cleaned/mrpropered.

I wonder how hard it would be to do this for other files types. It would be 
sort of handy to be able to copy a single file out of the source tree into 
the build tree, and have the build use the copy in the build tree. Example: 
you want to test a one liner in drivers/scsi/sd.c, you could just copy sd.c 
into the build tree, and make the change and test it out. That could be a 
huge space savings. That would help out those of us that are stuck with tiny 
hard drives in our laptops :) 

> 
> kconfig did not have an option to read the Kconfig files +
> defconfig from somewhere else than current directory,
> therefore they are copied. But that should be trivial to do.
> Possible solutions:
> 1) Command line option:
> 	-r path-to-rrot-of-tree
> 2) Deduct it from the argument given, but then kconfig
>    needs to know a bit too much about the kernel src tree.
> 3) Utilise the environment variable $(srctree), which is
>    anyway valid. 
> 
> Comments expected...

Excellent, I never really thought about it until I read this email, but it 
makes perfect sense(to me anyways). 

> 
> 	Sam 
> 
<snip>
