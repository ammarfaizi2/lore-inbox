Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319590AbSIMJsn>; Fri, 13 Sep 2002 05:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319592AbSIMJsn>; Fri, 13 Sep 2002 05:48:43 -0400
Received: from mta.sara.nl ([145.100.16.144]:22763 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S319590AbSIMJsm>;
	Fri, 13 Sep 2002 05:48:42 -0400
Date: Fri, 13 Sep 2002 11:53:20 +0200
Subject: Re: XFS?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
Message-Id: <A2AA8734-C6FE-11D6-A11E-000393911DE2@sara.nl>
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On vrijdag, september 13, 2002, at 09:47 , Ivan Ivanov wrote:

>
> XFS and JFS are designed for large multiprocessor machines powered by 
> UPS
> etc., where the risk of power fail, or some kind of tecnical problem is
> veri low.
>

Hmm, not entirely true. We run (C)XFS on Irix on our 1024 CPU SGI Origin 
3800 box over here. Every few weeks the @$%#@ thing breaks, (CPU, bad 
memory that kind of things). This takes down at least one partition of 
the system, and sometimes a filesystem (or all filesystems). Without the 
journaling features of XFS we'd spend all of our uptime fsck-ing. What 
I'm saying, big box with lots of parts has a lot of parts that could 
possible break....


> On the other side Linux works in much "risky" environment - old
> machines, assembled from "yellow" parts, unstable power suply and so on.
>
> With XFS every time when power fails while writing to file the entire 
> file
> is lost. The joke is that it is normal according FAQ :)
> JFS has the same problem.
> With ReiserFS this happens sometimes, but much much rarely. May be v4 
> will
> solve this problem at all.
>

Of course, loosing a file during a crash is not nice, but often the 
whole job has to be rerun, at least from it's last checkpoint, so 
loosing one file is not a problem. The same is true for most of the 
desktop work, it's much clearer to a user not to find his/her file in 
place, than a 'maybe corrupted' version.


> The above three filesystems have problems with badblocks too.
>
> So the main problem is how usable is the filesystem. I mean if a company
> spends a few tousand $ to provide a "low risky" environment, then may be
> it will use AIX or IRIX, but not Linux.
> And if I am running a <$1000 "server" I will never use XFS/JFS.
>

A few 1000 $ do not buy you an IRIX or a AIX box with support. So, 
spending that money wisely buys you a nice Linux box, decent hardware 
and a decent FS. Even in our very well protected environment, the 
no-break powersupply is able to fail in the most horrible way( thoiug 
that happend only once in over 20 years), having a robust FS is a must. 
There is a world of possibilities between spending $200 at Walmart for a 
low-end pc and >>$5k for your low-end IBM box. For 'small' servers that 
people will want to depend on, a decent FS is a must.

Now if XFS was as non-intrusive as FreeVFS, it probbably whould have 
been part of the main stream a long time ago. Unfortunately the XFS 
people wanted to provide functions not in the VFS layer... Now maybe if 
we cut that problem in two parts: filesystem and functional (dmapi 
IIRC), the intrusion into the VFS layer would not be taken as bad as it 
had been as it has been in the past....

- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9gbWYBIoCv9yTlOwRAuZNAJ9G+HxDINeeeT0QTZn7Ly1tpqHXAwCeLxCd
OMWrvLeT643az91jwHEq240=
=zAGH
-----END PGP SIGNATURE-----

