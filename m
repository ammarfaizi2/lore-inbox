Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUH3NNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUH3NNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267988AbUH3NNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:13:32 -0400
Received: from mail0.lsil.com ([147.145.40.20]:53127 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S267967AbUH3NNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:13:00 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC9C6@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: RE: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc
	 3.4
Date: Mon, 30 Aug 2004 09:05:02 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Thanks for the insight into the patch release process. We will make sure we
adhere to this process in future. I do have some concerns though:

1.	The initial announcement (see my mail on 8/24) did inline the
changelog and the patch against the previous version of the driver was sent
as attachment. I did mistakenly not add linux-scsi though.

2.	The guideline on the size of patches. Because of the new driver, the
size of the patches for megaraid are relatively big (the small patches are
always inlined). Should it be discretionary for submitter to either inline,
attach, or (deprecated) send a link, based on size of the package.

Thanks
-Atul Mukker

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Saturday, August 28, 2004 4:04 PM
> To: Mukker, Atul
> Cc: bunk@fs.tum.de; Atulm@lsil.com; sreenib@lsil.com; Manojj@lsil.com;
> linux-kernel@vger.kernel.org; James.Bottomley@SteelEye.com;
> linux-scsi@vger.kernel.org
> Subject: Re: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with
> gcc 3.4
> 
> 
> "Mukker, Atul" <Atulm@lsil.com> wrote:
> >
> > The driver and the patches with the re-ordered functions is 
> available at
> >  ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.20.3.1/
> 
> I dunno about James, but I *really* dislike receiving patches 
> by going and
> getting them from internet servers.  It breaks our 
> commonly-used tools.  It
> loses authorship info.  It loses Signed-off-by: info.  There is no
> changelog.  All this means that your patch is more likely to 
> be ignored by
> busy people.  Please, just email the diffs.
> 
> I wrote a little guide this week:
> 
> 
> 
> The perfect patch.  akpm@osdl.org
> 
> The latest version of this document may be found at
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
> 
> Delivery
> ========
> 
> - Patches are delivered via email only.  Downloading them 
> from internet
>   servers is a pain.
> 
> - One patch per email, with the changelog in the body of the email.
> 
> Subject:
> ========
> 
> - The email's Subject: should consisely describe the patch 
> which that email
>   contains.  The Subject: should not be a filename.  Do not 
> use the same
>   Subject: for every patch in a whole patch series.
> 
>   Bear in mind that the Subject: of your email becomes a 
> globally-unique
>   identifier for that patch.  It propagates all the way into 
> BitKeeper.  The
>   Subject: may later be used in developer discussions which 
> refer to the
>   patch.  People will want to google for the patch's Subject: to read
>   discussion regarding that patch.
> 
> - When sending a series of patches, the patches should be 
> sequence-numbered
>   in the Subject:
> 
> - It is nice if the Subject: includes mention of the 
> subsystem which it
>   affects.  See example below.
> 
> - Example Subject:
> 
> 	[patch 2/5] ext2: improve scalability of bitmap searching
> 
> - Note that various people's patch receiving scripts will strip away
>   Subject: text which is inside brackets [].  So you should 
> place information
>   which has no long-term relevance to the patch inside brackets.  This
>   includes the word "patch" and any sequence numbering.  The subsystem
>   identifier ("ext2:") should hence be outside brackets.
> 
> 
> Changelog
> =========
> 
> - Bear in mind that the Subject: and changelog which you provide will
>   propagate all the way into the permanent kernel record.  
> Other developers
>   will want to read and understand your patch and changelog 
> years in the
>   future.
> 
>   So the changelog should describe the patch fully:
> 
>   - why the kernel needed patching
> 
>   - the overall design approach in the patch
> 
>   - implementation details
> 
>   - testing results
> 
> - Don't bother mentioning what version of the kernel the 
> patch applies to
>   ("applies to 2.6.8-rc1").  This is not interesting 
> information - once the
>   patch is in bitkeeper, of _course_ it applied, and it'll 
> probably be merged
>   into a later kernel than the one which you wrote it for.
> 
> - Do not refer to earlier patches when changelogging a new 
> version of a
>   patch.  It's not very useful to have a bitkeeper changelog 
> which says "OK,
>   this fixes the things you mentioned yesterday".  Each 
> iteration of the patch
>   should contain a standalone changelog.  This implies that 
> you need a patch
>   management system which maintains changelogs.  See below.
> 
> - Add a Signed-off-by: line.
> 
> - Most people's patch receiving scripts will treat a ^--- 
> string as the
>   separator between the changelog and the patch itself.  You 
> can use this to
>   ensure that any diffstat information is discarded when the 
> patch is applied:
> 
> 
> 
> 	Another few #if/#ifdef cleanups, this time for the PPC 
> architecture.
> 
> 	Signed-off-by: <valdis.kletnieks@vt.edu>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	---
> 
> 	 25-akpm/arch/ppc/kernel/process.c                    |    2 +-
> 	 25-akpm/arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    2 +-
> 	 25-akpm/arch/ppc/syslib/ppc85xx_setup.c              | 
>    4 ++--
> 	 3 files changed, 4 insertions(+), 4 deletions(-)
> 
> 	--- 25/arch/ppc/kernel/process.c
> 	+++ 25/arch/ppc/kernel/process.c
> 	@@ -667,7 +667,7 @@ void show_stack(struct task_struct *tsk,
> 
> 
> The diff
> ========
> 
> - Patches should be in `patch -p1' form:
> 
>   --- a/kernel/sched.c
>   +++ b/kernel/sched.c
> 
> - Make sure that your patches apply to the latest version of 
> the kernel
>   tree.  Either straight from bitkeeper or from
>   ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/
> 
> - When raising patches for -mm it's generally best to base them on the
>   latest Linus tree.  I'll work out any 
> rejects/incompatibilities.  There are
>   of course exceptions to this.
> 
> - Ensure that your patch does not add new trailing 
> whitespace.  The below
>   script will fix up your patch by stripping off such whitespace.
> 
> 	#!/bin/sh
> 
> 	strip1()
> 	{
> 		TMP=$(mktemp /tmp/XXXXXX)
> 		cp $1 $TMP
> 		sed -e '/^+/s/[ 	]*$//' < $TMP > $1
> 		rm $TMP
> 	}
> 
> 	for i in $*
> 	do
> 		strip1 $i
> 	done
> 
> 
> Overall
> =======
> 
> - Avoid MIME and attachements if possible.  Make sure that 
> your email client
>   does not wordwrap your patch.  Make sure that your email 
> client does not
>   replace tabs with spaces.
> 
>   Mail yourself a decent-sized patch and check that it still applies.
> 
> 
> 
> The patch management scripts at 
> http://www.zip.com.au/~akpm/linux/patches/
> implement all of the above.
> 
> The patch management tools at 
> https://savannah.nongnu.org/projects/quilt/ also
> implement all of the above.
> 
