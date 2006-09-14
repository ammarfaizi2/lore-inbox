Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWINJ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWINJ3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWINJ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:29:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:7515 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751505AbWINJ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:29:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nykFDdi6wHk17MzndJHB0DeFSbz693ZjEL5/dBS583v2arM6MX04nh9i9gb97p5knLIc96PKd9NypNlHB2cRi/ZHE0emY/AxsAf2qmNaZZ/+ex6GkbRXKfxG7TEFbS9HLo4hKFmitTt970Ug5yp5F4Wcaz65jcOXBMOCXjE6fl4=
Message-ID: <6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com>
Date: Thu, 14 Sep 2006 11:29:51 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com
In-Reply-To: <20060914090808.GS3024@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com>
	 <6bffcb0e0609121634l7db1808cwa33601a6628ee7eb@mail.gmail.com>
	 <20060912163749.27c1e0db.akpm@osdl.org>
	 <20060913015850.GB3034@melbourne.sgi.com>
	 <20060913042627.GE3024@melbourne.sgi.com>
	 <6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com>
	 <20060914035904.GF3034@melbourne.sgi.com> <450914C4.2080607@gmail.com>
	 <6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com>
	 <20060914090808.GS3024@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/06, David Chinner <dgc@sgi.com> wrote:
> On Thu, Sep 14, 2006 at 10:50:42AM +0200, Michal Piotrowski wrote:
> > On 14/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > >David Chinner wrote:
> > >> On Wed, Sep 13, 2006 at 11:43:32AM +0200, Michal Piotrowski wrote:
> > >>> On 13/09/06, David Chinner <dgc@sgi.com> wrote:
> > >>>> I've booted 2.6.18-rc6-mm2 and mounted and unmounted several xfs
> > >>>> filesystems. I'm currently running xfsqa on it, and I haven't seen
> > >>>> any failures on unmount yet.
> > >>>>
> > >>>> That test case would be really handy, Michal.
> > >>> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/test_mount_fs.sh
> > >>>
> > >>> ls -hs /home/fs-farm/
> > >>> total 3.6G
> > >>> 513M ext2.img  513M ext4.img  513M reiser3.img  513M xfs.img
> > >>> 513M ext3.img  513M jfs.img   513M reiser4.img
> > >>
> > >> Ok, so you're using loopback and mounting one of each filesystem, then
> > >> unmounting them in the same order. I have mounted and unmounted an
> > >> XFS filesystem in isolation in exactly the same way you have been, but
> > >> I haven't seen any failures.
> > >>
> > >> Can you rerun the test with just XFS in your script and see if you
> > >> see any failures? If you don't see any failures, can you add each
> > >> filesystem back in one at a time until you see failures again?
> > >
> > >
> > >I still get an oops (with xfs only). Maybe it's file system image problem.
> > >
> > >xfs_info /mnt/fs-farm/xfs/
> > >meta-data=/dev/loop1             isize=256    agcount=8, agsize=16384 blks
> > >         =                       sectsz=512
> > >data     =                       bsize=4096   blocks=131072, imaxpct=25
> > >         =                       sunit=0      swidth=0 blks, unwritten=1
> > >naming   =version 2              bsize=4096
> > >log      =internal               bsize=4096   blocks=1200, version=1
> > >         =                       sectsz=512   sunit=0 blks
> > >realtime =none                   extsz=65536  blocks=0, rtextents=0
> >
> > Can I send to you this fs image? It's only 246KB bz2 file.
>
> I've downloaded it, and I don't see a panic on that fs at all.
> I've got it sitting in a tight loop mounting and unmounting the
> image you sent me, and nothing has gone wrong. I don't think it's
> a corrupted filesystem problem - it seems more like a memory corruption
> problem to me.

I'm checking memory from time to time with memtest86.

>
> What arch are you running on and what compiler are you using?

gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--enable-checking=release --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-libgcj-multifile
--enable-languages=c,c++,objc,obj-c++,java,fortran,ada
--enable-java-awt=gtk --disable-dssi
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
--with-cpu=generic --host=i386-redhat-linux
Thread model: posix
gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)

I'll build system with gcc 3.4

> Can you try 2.6.18-rc6 and see if it panics like this on your
> machine?

2.6.18-rc7 works fine.

> there is little difference in xfs between -rc6 and -rc6-mm2
> so it would be good to know if this is a problem isolated to
> the -mm tree or not....
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> Principal Engineer
> SGI Australian Software Group
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
