Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbREQQve>; Thu, 17 May 2001 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbREQQvY>; Thu, 17 May 2001 12:51:24 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:13162
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S262045AbREQQvI>; Thu, 17 May 2001 12:51:08 -0400
Message-ID: <3B040179.7090807@fugmann.dhs.org>
Date: Thu, 17 May 2001 18:51:05 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac9 i686; en-US; rv:0.9+) Gecko/20010513
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting symbols from a module.
In-Reply-To: <200105152245.f4FMjnwN021983@webber.adilger.int> <3B03B5C7.5040107@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved.

I just looked at what the kernel did whne compiling a module that 
exported some symbols, and discovered that I needed
to set CFLAGS to:

-D__KERNEL__ -I$/usr/src/linux)  -Wall -Wstrict-prototypes \
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe \
-DMODULE  -DMODVERSIONS -include \
/usr/src/linux/modversions.h

Now all works correctly, and I can load my modules.

Thanks for all your help.
eps. the tip when I try to compile it in the kernel tree.

Anders Fugmann



Anders Peter Fugmann wrote:

> Hi Andreas.
> 
> I now see what you mean, and I will give it a try.
> 
> But actually I'm not compiling it under the linux kernel tree, and  I 
> really would like a way to export symbols, while compiling outside the 
> kernel tree. How would I accomplish that?
> 
> Regards
> Anders Fugmann
> 
> 


