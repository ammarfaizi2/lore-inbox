Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbQKTTyN>; Mon, 20 Nov 2000 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQKTTyE>; Mon, 20 Nov 2000 14:54:04 -0500
Received: from ppp17.ts1-1.NewportNews.visi.net ([209.8.196.17]:47092 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S129884AbQKTTx4>; Mon, 20 Nov 2000 14:53:56 -0500
Date: Mon, 20 Nov 2000 14:16:41 -0500
From: Ben Collins <bcollins@debian.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Zdenek Kabelac <kabi@fi.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
Message-ID: <20001120141641.Y619@visi.net>
In-Reply-To: <D69EF5976ED@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D69EF5976ED@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Nov 20, 2000 at 07:32:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 07:32:39PM +0000, Petr Vandrovec wrote:
> On 20 Nov 00 at 13:19, Ben Collins wrote:
> > 
> > Does kernel 2.4.x compile and run well for all of our supported archs?
> 
> AFAIK yes. At least on all Debian archs.

So, sparc, ultrasparc, i386 (with pcmcia support), alpha, arm, m68k,
powerpc? I know that mips, s390 and hppa almost require a 2.4.0 kernel,
even if they aren't stable yet. But the other ports are more important,
because we released them already, so we have a certain status quo to keep
them working well.

Anyway, this isn't a major point.

> > Do programs compiled against a glibc with LFS (2.4.x kernel) support, and
> > using that LFS support, work on kernel 2.2.x machines?
> 
> Yes. Even glibc (2.2) compiled against kernel without LFS support has LFS
> interface. Of course limited to 2GB files only.

On some platforms...

E.g. I can already access > 2gig files on my ultrasparc :)

> > Secondly, anyone who thinks they know what they are doing, can simply
> > download the Debian glibc sources files, and build against kernel-2.4.0
> > headers with this simple command:
> > 
> > LINUX_SOURCE=/usr/src/linux-2.4.0-test11 apt-get -b source glibc
> > 
> > Simple, eh? :)
> 
> But time consuming... If you already invested CPU power to compile
> that large beast...

Well, patience is a virtue. Right now we don't have it in Debian for some
very good reasons. We just transitioned to a new glibc (2.2 is there, and
it works almost flawlessly, thanks to the glibc folks). Next step is gcc3
and kernel 2.4. Both of those combined promise to introduce some new and
exciting bugs and conflicts. We can't just "dump them in there". We'de
rather make a sane migration, test upgrades from previous versions, and
work in our transition mechanisms. IOW, we don't have to just worry about
1 architecture and 1 distribution, we have to make sure upgrades work,
make sure things don't break, and ensure backward compatibility is retained
for 5 architectures that have released already (new archs don't need a
transisition obviously).

That's a large undertaking, but the good thing is, in the end, the wait
will be worth it to our users. People wont be stuck with Debian 2.2,
simply because they can't do a decent upgrade to 2.3, when that releases.

The issue is already known, and yes it will get done in time. Getting all
strung out about a kernel that isn't even released stable yet, is not
going to help :)

Ben

-- 
 -----------=======-=-======-=========-----------=====------------=-=------
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
