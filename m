Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSFWUP2>; Sun, 23 Jun 2002 16:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSFWUPZ>; Sun, 23 Jun 2002 16:15:25 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:62883 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S317110AbSFWUNn>; Sun, 23 Jun 2002 16:13:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild fixes and more
Date: Sun, 23 Jun 2002 22:16:58 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0206231325280.6241-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0206231325280.6241-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020623201514Z317110-22020+9309@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 23 June 2002 20:39, Kai Germaschewski wrote:
> I suppose we won't see any official / -dj releases any time soon, since
> everybody is at OLS, so I figured it may make sense to publish my
> current tree, which fixes some outstanding build problems and adds more
> cleanup.
>
> Most notably:
>
> make KBUILD_VERBOSE= bzImage
>
> (or export KBUILD_VERBOSE=0 / setenv KBUILD_VERBOSE 0; make bzImage)
>
> looks certainly improved now.
>
> Fixes include:
> o the defkeymap/loadkeys issue
> o calling host programs for khttpd / soundmodem
> o make net_dev_init() a subsys_initcall, to make sure it's called
>   before any net device registers.
>
> Patch is available from
>
> http://www.tp1.ruhr-uni-bochum.de/~kai/kbuild/patch-2.5.24-kg1.gz
>
> 	or
>
> bk pull http://linux-isdn.bkbits.net/linux-2.5.make
>
>
> Feedback is very welcome, of course ;)

patched against 2.5.24-dj1 (one failed hunk) generates errors:
# make clean
<snip>
make -C /aicasm clean
make: Entering an unknown directory
make: *** /aicasm: No such file or directory.  Stop.
make: Leaving an unknown directory
make[3]: *** [clean] Error 2
make[3]: Leaving directory 
`/usr/src/kernel/linux-2.5.24-dj1/drivers/scsi/aic7xxx'
make[2]: *** [aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/kernel/linux-2.5.24-dj1/drivers/scsi'
make[1]: *** [scsi] Error 2
make[1]: Leaving directory `/usr/src/kernel/linux-2.5.24-dj1/drivers'
make: *** [_clean_drivers] Error 2

patching it against 2.5.24 (starting from 2.5.13 and patched up to) gives the 
same failed hunk as with 2.5.24-dj1

patching it against 2.5.24 (the tarball) generates a lot of failures and 
offsets...

so i would like to try it, but it just is not possible...

	Rudmer
