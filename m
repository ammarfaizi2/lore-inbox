Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284036AbRLAJrw>; Sat, 1 Dec 2001 04:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLAJrm>; Sat, 1 Dec 2001 04:47:42 -0500
Received: from web20505.mail.yahoo.com ([216.136.226.140]:22799 "HELO
	web20505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284036AbRLAJrf>; Sat, 1 Dec 2001 04:47:35 -0500
Message-ID: <20011201094733.84784.qmail@web20505.mail.yahoo.com>
Date: Sat, 1 Dec 2001 10:47:33 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Did someone try to boot 2.4.16 on a 386 ? [SOLVED] 
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <13800.1007198991@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But try telling people that shipping files then
> overwriting them is a bad idea.

if a file is to be modified, then it ought to be
copied at make time, deleted at clean time, and
only its copy should be used. Anyway, by definition,
a modified file is not a source anymore.
 
> The moment you use cp -al on a kernel source tree,
> you are running the risk of time stamp problems.
> 
>   cp -al pristine tree1
>   cp -al pristine tree2
>   cd tree1
>   make *config bzImage
>   cd tree2
>   make *config bzImage
> 
> The make in tree1 and tree2 touches the time stamps
> on included files. Because most include files are
> hard linked, it changes the time stamps on all three
> trees, including the pristine source. Even if you
> never compile in tree1 and tree2 at the same time,
> when you switch back and forth between trees you
> will get semi-random time stamp changes.

so a recursive touch before a make in such a tree
should be safer ?

> Normally the unwanted time stamp updates only forces
> spurious recompiles, but I believe that there are
> some sequences that create an incomplete kernel
> build.

Although I can't swear I never encountered this
problem, I can tell that I already had some
interrogations about strangely compiled kernels
which led me to repatch against a clean tree.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
