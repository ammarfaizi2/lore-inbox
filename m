Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130257AbRBBWfV>; Fri, 2 Feb 2001 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130259AbRBBWfL>; Fri, 2 Feb 2001 17:35:11 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:3086 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130257AbRBBWfB>; Fri, 2 Feb 2001 17:35:01 -0500
Message-ID: <3A7B2E94.F52C4342@namesys.com>
Date: Sat, 03 Feb 2001 01:03:00 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: John Morrison <john@vmlinux.net>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102022139.f12LdII21148@devserv.devel.redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > It makes sense to refuse to build a piece of the kernel if it break's
> > a machine - anything else is a timebomb waiting to explode.
> 
> The logical conclusion of that is to replace the entire kernel tree with
> 
> #error "compiler or program might have a bug. Aborting"

No, this is a compiler that DOES have a bug.  ReiserFS is, as best as I can make
it, for mission critical servers where some sysadmin doesn't want to
explain it to the CEO.  There are plenty of ways that I fail at this, but not
intentionally.

These sorts of mission critical servers are frequently installed by persons
short on sleep because a whole lot of things more interesting than ReiserFS
had to be gotten working for that server, and who are barely able to convince
their boss that compiling a kernel themselves is an okay thing for them to be
allowed to do.

Taking an attitude of, you didn't read the README, you didn't read Slashdot, you
just assumed the distro wouldn't install a compiler unable to compile the
kernel, you lose, is not the way I treat such customers.

Our users have better things to do than read our FAQ.  They REALLY do.  ReiserFS
is a product of only marginal interest to them.  They trust that
it will just work because it isn't a Microsoft product.

My design objective in ReiserFS is not to say that it wasn't my fault they had
that bug because they are so ignorant about a filesystem that
really isn't very important to them unless it screws up.  My design objective is
to ensure they don't have that bug.  They are more important than me.


> 
> The kernel is NOT some US home appliance festooned with 'do not eat this
> furniture' and 'do not expose your laserwrite to naked flame' messages.
> The readme says its been tested with egcs-1.1.2 and gcc 2.95.
> 
> The same people who can't read documentation will just mail the list with
> 'it doesnt compile, help' or 'it doesnt compile, you suck' in less enlightened
> cases/
> 
> Large numbers of people routinely build the kernel with 'unsupported' compilers
> notably the pgcc project people and another group you will cause problems for
> - the GCC maintainers. They use the kernel tree as part of the test set for
> their kernel, something putting #ifdefs all over it will mean they have to
> mess around to fix too.
> 
> Alan

A moment of precision here.  We won't test to see if the right compiler is used,
we will just test for the wrong one. 

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
