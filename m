Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316719AbSEQXCd>; Fri, 17 May 2002 19:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316725AbSEQXCc>; Fri, 17 May 2002 19:02:32 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:27143 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316719AbSEQXCb>; Fri, 17 May 2002 19:02:31 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BBC.007E84E7.00@smtpnotes.altec.com>
Date: Fri, 17 May 2002 17:59:28 -0500
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have nothing against it being faster -- *as long as nothing about the way I
use it changes.*  Most of my kernel upgrades are done while I'm at work,
programming, doing Solaris system admin, sitting in meetings, making phone
calls, or any of the other things my employer is paying me to do.  I have a cron
job that checks kernel.org periodically and pops up a message on my screen when
a new kernel patchset appears there.  When that happens, I quickly switch to
another virtual console, ftp the patch, and then:

zcat patch-X.Y.Z.gz | patch -p1 -s -E
mv .config ..
make mrproper
mv ../.config .
make oldconfig
make dep && make bzlilo modules modules_install

Then I go back to work.  When the compile finishes I stop long enough to reboot,
then start working again, and unless there's a problem, don't give another
thought to it until the next patchset is ready.

I have all this down to a science.  All these commands are in my bash command
history so I can pull them up with a couple of keystrokes.  I've done them all
so many times that I can type them from scratch almost without thinking about
them.  I've gone through this whole process while in the midst of business
conversations without anyone even noticing that I'm doing it.  (Of course, if
there are compile errors it's another story, and I have to deal with those
later, but often I can go through several upgrades in a row without any errors.)
Anything that changes this process -- new commands, new syntax, whatever --
takes extra time and disrupts whatever else I'm doing.

Different people have different needs.  I don't care how many new bells and
whistles the developers add for their own use, but it would be nice if those of
us who just want to apply patches and recompile with a minimum of fuss could
keep our old user interfaces.





Nicolas Pitre <nico@cam.org> on 05/17/2002 05:09:20 PM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3




But even if you recompile *everything* _everytime_, kbuild 2.5 is "faster".

What do you have against that?


Nicolas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




