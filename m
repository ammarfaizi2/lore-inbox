Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271132AbRHOKwR>; Wed, 15 Aug 2001 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRHOKwH>; Wed, 15 Aug 2001 06:52:07 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:65009 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S271132AbRHOKv6>; Wed, 15 Aug 2001 06:51:58 -0400
Date: Wed, 15 Aug 2001 12:52:07 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: God <atm@sdk.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] :: "Value too large for defined data type"
Message-ID: <20010815125207.E9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>; from atm@sdk.ca on Wed, Aug 15, 2001 at 04:22:05AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi helpless God, ;-)

On Wed, Aug 15, 2001 at 04:22:05AM -0400, God wrote:
> </mental picture>
> 
> ... dump crashed with:
> 
>   DUMP: 78.80% done at 814 kB/s, finished in 0:10
>   DUMP: error reading command pipe in master: No such file or directory
>   DUMP: The ENTIRE dump is aborted.
 
> 
> Trying to check where dump should have written the file on box2, I get:
> 
> # ls -al
> /bin/ls: test: Value too large for defined data type
> total 2097216
> drwxrwxrwx   2 root     root        32768 Aug 14 23:27 ./
> drwxrwxrwx  50 root     root        32768 Aug 14 21:02 ../
> -rwxrwxrwx   1 root     root     2147483647 Aug 14 22:11
> box1.071401.dump*
> #

Your /bin/ls box2 is not LFS[1] aware. Maybe your dump isn't either?

> Ok so I lied, that is a paste from after my little expriment, but you can
> see the file size.  2.1G, out of a 3G drive.

Looks like LFS problem somewhere.

> It was a stupid thing to do, but could there be a better way for the OS to
> handle this and is there any way I can remove the file?  It's on  a 60
> Gig drive, so formatting would not be an option right about now ...

Use some rm, which has been compiled for LFS. If your glibc
doesn't support it, then you can only help yourself with some
boot disk with LFS aware tools.


Regards

Ingo Oeser

[1] Large File Support = Support for using large files on a file system
