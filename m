Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317810AbSFSICl>; Wed, 19 Jun 2002 04:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317811AbSFSICk>; Wed, 19 Jun 2002 04:02:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5901 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317810AbSFSICi> convert rfc822-to-8bit;
	Wed, 19 Jun 2002 04:02:38 -0400
Message-ID: <3D103A88.2050007@evision-ventures.com>
Date: Wed, 19 Jun 2002 10:02:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Various kbuild problems in 2.5.22
References: <Pine.LNX.4.44.0206181056090.5695-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Kai Germaschewski napisa³:
> On Tue, 18 Jun 2002, Adam J. Richter wrote:
> 
> 
>>	No, "make -k" still will not build bzImage if a module
>>fails to compile.
>>
>>	Also, I do not understand why this is "intentional."  Normally,
>>if one does a "make" of a file in a source tree, build problems with
>>unneeded files do not effect it.
> 
> 
> Yes, but they are not unneeded files, otherwise we wouldn't even try to 
> build them. The point is, the semantics of bzImage changed: It now means 
> "build bzImage and modules". That's the common case. If you really only 

It is very inconenient if you are working only on some things
which don't affect any thing you are compiling as a module
during the edit/compile cycle or if you don't care to update
some modules you have just in case configured during developement.

How does one build the sole non modularized part of the kernel
nowadays? (Note: it is inconvenient now, but I'm not insisting.)

> want bzImage and no modules, you have to tell make by using
> "make KBUILD_MODULES= bzImage" (I could allow for phrasing the latter as
> "make bzImage nomodules", but that's only cosmetical)

