Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRDCAYb>; Mon, 2 Apr 2001 20:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDCAYM>; Mon, 2 Apr 2001 20:24:12 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3539 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131756AbRDCAYK>;
	Mon, 2 Apr 2001 20:24:10 -0400
Message-ID: <3AC91800.22D66B24@mandrakesoft.com>
Date: Mon, 02 Apr 2001 20:23:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Ian Soboroff <ian@cs.umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <877l13whzw.fsf@danube.cs.umbc.edu> <3AC89389.46317572@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> Yes, I like this.  I do this manually, it allows reproducability, and
> incremental
> modifications, tracing how that kernel on that problem system was made...
> 
> I think the ultimate would be to put all of .config (gzipped?) in a new ELF
> section without the Loadable attribute...  I wish System.map was the same.
> The you're guaranteed you know how a kernel on disk was configured.
> 
> To correlate a running kernel to one on disk (vmlinuz) you have LILO...
> it appends an environment variable to the kernel command line with
> the name of the file it booted.  This is not infallable, since LILO maps
> disk sectors, only using the filesystem at map install time.
> 
> Permaps an md5sum of the .text ELF section would conclusively
> link the in-core kernel with an on-disk vmlinuz?  Shouldn't be hard
> to do with objcopy and /proc/kmem?
[...]
> Comments anyone?

Instead of doing all this stuff in the kernel, you could simply update
symlinks to properly installed files at boot time.

Putting _files_ in the kernel is plain silly.  This is unreclaimable
memory, folks.  There is no need to special case an operation as simple
as reading a file.  [I think this about firmware images too, but that's
another thread]

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
