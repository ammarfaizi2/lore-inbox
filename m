Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSFKGd1>; Tue, 11 Jun 2002 02:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316854AbSFKGd0>; Tue, 11 Jun 2002 02:33:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36366 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316853AbSFKGdX>; Tue, 11 Jun 2002 02:33:23 -0400
Message-ID: <3D0599AE.7080809@evision-ventures.com>
Date: Tue, 11 Jun 2002 08:33:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 10, 2002 at 01:26:53PM +0200, Martin Dalecki wrote:
> 
>>Fix improper usage of __FUNCTION__ in usb code.
> 
> 
> It's not improper.  Well it wasn't when it was written, but the gcc
> authors decided to change their minds... :(
> 
> As stated before, I'll clean up all of the USB drivers later all at
> once, and the pci hotplug drivers as well.  The USB drivers could use
> with some good debugging macro cleanup in general...
> 
> Martin, any reason you are doing all of this "cleanup" without sending
> the patches to the relevant maintainers?

1. I know you read lkml.

2. The patches are trival.

3. Having them helps using GCC 3.1, which turns out to be a big
winner contrary to 3.0.xx.

4. I use GCC 3.1 becouse I hate having different compilers on the system
    and becouse I do some C++ too.

5. We have to do it anyway - so what?

6. In esp. ARM seems to be much better off with GCC 3.1 then anything else.

7. Separating __FUNCTION__ out from string const concatenation allows
the compiler to coalesce the storage used for this string in to one constant!

