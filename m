Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315115AbSDWJXo>; Tue, 23 Apr 2002 05:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSDWJXn>; Tue, 23 Apr 2002 05:23:43 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:7605 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S315115AbSDWJXm>; Tue, 23 Apr 2002 05:23:42 -0400
Date: Tue, 23 Apr 2002 11:23:31 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available
Message-ID: <20020423112331.B1142@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020422163606.A1142@riesen-pc.gr05.synopsys.com> <5928.1019516614@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oops, sorry about the trouble.

This time:
+ kbuild-2.5-core-6
+ kbuild-2.5-common-2.5.8-3
+ kbuild-2.5-i386-2.5.8-1

Small issue with generation of defkeymap.c:
i got error that there was no permission to write in the file from
/bin/sh. Sorry, accidentially typed Ctrl-L in terminal and the error was
lost. I'll try to reproduce it (it's not every time).

Btw, why it isn't possible to run "make clean installable"?
Or at least "make clean oldconfig installable"?


On Tue, Apr 23, 2002 at 09:03:34AM +1000, Keith Owens wrote:
> On Mon, 22 Apr 2002 16:36:06 +0200, 
> Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
> >On Sun, Apr 21, 2002 at 05:43:08PM +1000, Keith Owens wrote:
> >> 
> >> Release 2.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
> >> http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
> >> release 2.1.
> >> 
> >
> >Hi, i've got some problems with 2.1:
> >.../v2.5-1/arch/i386/kernel/entry.S:223: unterminated character constant
> >.../v2.5-1/arch/i386/kernel/entry.S:264: unterminated character constant
> >.../v2.5-1/arch/i386/kernel/entry.S:280: unterminated character constant
> >That was Linus's bk tree (cset 1.562)
> >+ kbuild-2.5-core-4
> >+ kbuild-2.5-common-2.5.8-pre3-1
> >+ kbuild-2.5-i386-2.5.8-pre3-1
> 
> Those are not release 2.1 files, you are using old patches.  Release
> 2.1 uses core-6 and patches for 2.5.8, not 2.5.8-pre3.
> 
> >P.S. "phase 1" for xconfig is evil, is it absolutely unavoidable?
> 
> Yes.  A driver may not be in the main kernel source tree, it can be in
> a separate tree.  Phase 1 finds all the files in all trees, including
> config files.
