Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRBLDmo>; Sun, 11 Feb 2001 22:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRBLDmf>; Sun, 11 Feb 2001 22:42:35 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:38662 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130216AbRBLDmU>;
	Sun, 11 Feb 2001 22:42:20 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102120341.f1C3fHa47166@saturn.cs.uml.edu>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Sun, 11 Feb 2001 22:41:17 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        ahzz@terrabox.com (Brian Wolfe),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <3A7E904F.797AF09B@namesys.com> from "Hans Reiser" at Feb 05, 2001 02:36:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
> Alan Cox wrote:
>> [Ablert Cahalan]

>>> In an __init function, have some code that will trigger the bug.
>>> This can be used to disable Reiserfs if the compiler was bad.
>>> Then the admin gets a printk() and the Reiserfs mount fails.
>>
>> Thats actually quite doable. I'll see about dropping the test
>> into -ac that way.
>
> NOOOOO!!!!!! It should NOT fail at mount time, it should fail
> at compile time.

Detection at compile time is not reliable. Just last week, on a
plain x86 box with a good gcc, I was compiling with a compiler
called "/usr/local/bin/powerpc-linux-gcc". Guess what that does.

My compiler was not in the RPM database. My compiler could not
produce executables that would run on the build system, so build-time
tests wouldn't work. Compiler version information is fairly useless,
since x86-specific bugs don't matter at all. Maybe I even patched
my compiler.

Complaints about the local compiler are useful, but not sufficient.
They only protect the menuconfig program, the mkdep program...
As above, actual bug tests are better than trying to interpret
what the compiler reports for a version.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
