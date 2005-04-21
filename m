Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVDUTDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVDUTDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVDUTDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:03:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:18318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261785AbVDUTDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:03:20 -0400
Date: Thu, 21 Apr 2005 12:03:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Cosmin Nicolaescu <cos@camelot.homelinux.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH 2.6.11] Documentation: correct minor mistake and  
 remove redundant info from SubmittingPatches
Message-Id: <20050421120306.7eb76d72.rddunlap@osdl.org>
In-Reply-To: <20050421185109.4004.qmail@camelot.homelinux.com>
References: <20050421185109.4004.qmail@camelot.homelinux.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005 14:51:09 -0400 Cosmin Nicolaescu wrote:

| The first fix is to reverse the order of the files being diffed. Since
| we make the change in $MYFILE (and not $MYFILE.orig}, the diff should
| have the .orig file first followed by $MYFILE (which has been
| modified).

But the patch below has the .orig file second, not first.
Looks like it's backwards.... (reversed)

| The second modification is to remove redundant text. The information
| about the Trivial Patch Monkey is both in steps 4 and 5. Since trivial
| should be CCed, the information should only go in step 5 (Select your
| CC list) and be removed from step 4 (Select e-mail destination).

The second patch chunk adds text, not removes it.

| --- linux-2.6.11/Documentation/SubmittingPatches        2005-04-21 14:22:22.242714051 -0400
| +++ linux-2.6.11/Documentation/SubmittingPatches.orig   2005-04-21 14:17:07.375698154 -0400
| @@ -42,7 +42,7 @@ To create a patch for a single file, it 
|         cp $MYFILE $MYFILE.orig
|         vi $MYFILE      # make your change
|         cd ..
| -       diff -up $SRCTREE/$MYFILE{,.orig} > /tmp/patch
| +       diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch
|  
|  To create a patch for multiple files, you should unpack a "vanilla",
|  or unmodified kernel source tree, and generate a diff against your
| @@ -132,6 +132,21 @@ which require discussion or do not have 
|  usually be sent first to linux-kernel.  Only after the patch is
|  discussed should the patch then be submitted to Linus.
|  
| +For small patches you may want to CC the Trivial Patch Monkey
| +trivial@rustcorp.com.au set up by Rusty Russell; which collects "trivial"
| +patches. Trivial patches must qualify for one of the following rules:
| + Spelling fixes in documentation
| + Spelling fixes which could break grep(1).
| + Warning fixes (cluttering with useless warnings is bad)
| + Compilation fixes (only if they are actually correct)
| + Runtime fixes (only if they actually fix things)
| + Removing use of deprecated functions/macros (eg. check_region).
| + Contact detail and documentation fixes
| + Non-portable code replaced by portable code (even in arch-specific,
| + since people copy, as long as it's trivial)
| + Any fix by the author/maintainer of the file. (ie. patch monkey
| + in re-transmission mode)
| +

---
~Randy
