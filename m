Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSITIAX>; Fri, 20 Sep 2002 04:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSITIAX>; Fri, 20 Sep 2002 04:00:23 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:33223 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261509AbSITIAW>; Fri, 20 Sep 2002 04:00:22 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Miles Lane <miles.lane@attbi.com>
Subject: Re: Dont understand hdc=ide-scsi behaviour.
Date: Fri, 20 Sep 2002 17:59:03 +1000
User-Agent: KMail/1.4.5
Cc: Reg Clemens <reg@dwf.com>, linux-kernel@vger.kernel.org
References: <200209192108.g8JL8iT6010419@orion.dwf.com> <200209201646.00202.bhards@bigpond.net.au> <1032533179.4526.102.camel@firehose.megapathdsl.net>
In-Reply-To: <1032533179.4526.102.camel@firehose.megapathdsl.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209201759.03744.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

WARNING: this email is even more clueless than my normal posting standard.

On Sat, 21 Sep 2002 00:46, Miles Lane wrote:
> Well, aren't things going to get even more confusing when we
> try to support devices like the Lacie DVD/CD Rewritable
> combo drive?  Are we going to do a better job of simply making
> all usable interfaces available, so we no longer need to switch
> between drivers or twiddle driver load order?


Don't know the product, but I take it that this is a single IDE drive that can 
read and write CDs, and read (and perhaps write) DVDs? If you want to write, 
use ide-scsi+sg+scd, else just use ide-cdrom.

Until we have another userspace and kernel combination for writing, you are 
stuck with cdrecord and sg. It'd be an vaguelly interesting exercise to have 
a CD burning app that worked natively with ide-cdrom, but I have about a 
million more important things to do before I'd start on that :)

If anyone is interested in coding this, what I'd really like to see is a CD 
burning library that works with sg and ide-cdrom. You'd probably need to 
modify ide-cdrom - I have no real idea about ATAPI or any other block device. 

Then we could move away from GUIs that are really all just running the same 
command line application, and get some more interesting handling going. 

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9itVHW6pHgIdAuOMRAumwAKCUzrDf7t4iRAHBWzSWyxHLLzOYQgCgvH73
URyJjN3asd8ZfKUa003K8sc=
=1Aws
-----END PGP SIGNATURE-----

