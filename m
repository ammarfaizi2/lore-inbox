Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271293AbTG2Geb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 02:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTG2GdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 02:33:14 -0400
Received: from [213.69.232.58] ([213.69.232.58]:20488 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S271283AbTG2GdC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 02:33:02 -0400
Date: Tue, 29 Jul 2003 00:26:42 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Steve Lord <lord@sgi.com>
Cc: scholz@wdt.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in 2.6.0test2
Message-ID: <20030728222641.GE10741@schottelius.org>
References: <20030728115902.GA18993@schottelius.org> <1059425249.6601.10.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1059425249.6601.10.camel@jen.americas.sgi.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux pinguin-02 2.4.18
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord [Mon, Jul 28, 2003 at 03:47:30PM -0500]:
> On Mon, 2003-07-28 at 06:59, Nico Schottelius wrote:
> > Hello again!
> > 
> > When trying to boot from a cryptoloop we get the attached error.
> > Details:
> >    modules loop,cryptoloop,aes (in this order) are loaded with insmod
> >    (from initrd)
> >    then mounting proc
> > 
> > Any suggestions / solutions ?
> > 
> > Nico
> > 
> > ps: please cc me and scholz AT wdt.de
> 
> Something else went wrong before you crashed:
> 
> bio too big device loop0 (2 > 0)
> 
> This means you cannot use any bio larger than zero to this device,

assume i didn't understand very much you told me..what is a bio?
how do I use it? and why is it too big here?

> which is probably why ext2 said this, since it caught the error when
> building the bio.

ext2? I am wondering..afai understood that, the root wasn't even
decrypted, how can the kernel try to ext2-mount it?

> EXT2-fs: unable to read superblock
> 
> XFS didn't catch the error building the bio and submitted it, at
> which point the I/O tripped the BUG. I can fix this part, but
> the original problem is something I know nothing about.

..or better why does it start mounting/before decrypt?


Nico

-- 
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new
