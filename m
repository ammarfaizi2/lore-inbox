Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSAZDtz>; Fri, 25 Jan 2002 22:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290519AbSAZDtk>; Fri, 25 Jan 2002 22:49:40 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:43650 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289012AbSAZDtg>; Fri, 25 Jan 2002 22:49:36 -0500
Date: Sat, 26 Jan 2002 03:45:59 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dan Maas <dmaas@dcine.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020126034559.G5730@kushida.apsleyroad.org>
In-Reply-To: <fa.juevf8v.1u7ubb8@ifi.uio.no> <fa.h3u09pv.1v2k3bm@ifi.uio.no> <037801c1a60e$d897e230$1d01a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <037801c1a60e$d897e230$1d01a8c0@allyourbase>; from dmaas@dcine.com on Fri, Jan 25, 2002 at 09:12:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> This may be true for environments where people mostly run a handful of
> monolithic applications (*ahem* windows) but look at typical Linuxy things
> like:
> 
> make (compiler, assembler, linker processes...)
> forking servers (Apache 1.x...)
> *./configure scripts* (a big one!!!)
> etc...
> 
> Startup cost is likely to be a big factor here...

Btw, a little story about startup times and Linux.

I once wrote a Perl script that needed to know the current directory.
It did:

   use POSIX 'getcwd'
   getcwd(...)

After a few months, I was annoyed by the slowness of this script
(compared with other scripts) and decided to try speeding it up.  It
turns out that the above two lines took about 0.25 of a second, and that
was the dominant running time of the script.

I replaced getcwd() with `/bin/pwd`.  Lo!  It took about 0.0075 second.

Says very good things about Linux' fork, exec and mmap times, and about
Glibc's dynamic loading time, I think.

-- Jamie
