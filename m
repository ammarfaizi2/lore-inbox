Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130602AbRBLKSv>; Mon, 12 Feb 2001 05:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130608AbRBLKSn>; Mon, 12 Feb 2001 05:18:43 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:57865 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S130602AbRBLKSg>; Mon, 12 Feb 2001 05:18:36 -0500
Message-ID: <3A87B0D7.F5D7A081@namesys.com>
Date: Mon, 12 Feb 2001 12:45:59 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Wolfe <ahzz@terrabox.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <200102120341.f1C3fHa47166@saturn.cs.uml.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Hans Reiser writes:
> > Alan Cox wrote:
> >> [Ablert Cahalan]
> 
> >>> In an __init function, have some code that will trigger the bug.
> >>> This can be used to disable Reiserfs if the compiler was bad.
> >>> Then the admin gets a printk() and the Reiserfs mount fails.
> >>
> >> Thats actually quite doable. I'll see about dropping the test
> >> into -ac that way.
> >
> > NOOOOO!!!!!! It should NOT fail at mount time, it should fail
> > at compile time.
> 
> Detection at compile time is not reliable. Just last week, on a
> plain x86 box with a good gcc, I was compiling with a compiler
> called "/usr/local/bin/powerpc-linux-gcc". Guess what that does.
> 
> My compiler was not in the RPM database. My compiler could not
> produce executables that would run on the build system, so build-time
> tests wouldn't work. Compiler version information is fairly useless,
> since x86-specific bugs don't matter at all. Maybe I even patched
> my compiler.
> 
> Complaints about the local compiler are useful, but not sufficient.
> They only protect the menuconfig program, the mkdep program...
> As above, actual bug tests are better than trying to interpret
> what the compiler reports for a version.

We only detect bad compilers, and our particular bad compiler only exists on one
particular distro, so it works.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
