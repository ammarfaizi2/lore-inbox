Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRB0OKf>; Tue, 27 Feb 2001 09:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRB0OKZ>; Tue, 27 Feb 2001 09:10:25 -0500
Received: from imcs.rutgers.edu ([165.230.57.130]:4807 "EHLO imcs.Rutgers.EDU")
	by vger.kernel.org with ESMTP id <S129401AbRB0OKR>;
	Tue, 27 Feb 2001 09:10:17 -0500
Date: Tue, 27 Feb 2001 08:59:27 -0500 (EST)
From: Rob Cermak <cermak@IMCS.rutgers.edu>
To: mshiju@in.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 compilation error
In-Reply-To: <CA256A00.0046A52B.00@d73mta05.au.ibm.com>
Message-ID: <Pine.SOL.4.21.0102270845320.8015-100000@imcs.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shiju,

There might be more things missing, but check this link:

ls -ld /usr/include/linux, it should be:

linux -> /usr/src/linux/include/linux

In which, your need to do this:
cd /usr/src
ln -s linux2.4.1 linux

If linux exists, remove the old symlink or move the directory out of the
way.

More compile notes are here:
       http://www.kernelnewbies.org/

Rob

On Tue, 27 Feb 2001 mshiju@in.ibm.com wrote:

> Hi all,
>      When I compiled 2.4.1 kernel  on a 2.2.14-5.0 installation (redhat
> 6.2) ,the following error occurred . But errno.h is there in
> /usr/src/linux2.4.1/include/linux/   directory. Have anyone experienced
> this problem.
> 
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
> scripts/split-include
> scripts/split-include.c
> In file included from /usr/include/errno.h:36,
>                  from scripts/split-include.c:26:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory
> make: *** [scripts/split-include] Error 1


