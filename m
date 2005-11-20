Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVKTWg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVKTWg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVKTWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:36:56 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:33878 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750861AbVKTWg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:36:56 -0500
Subject: Re: Linux 2.6.15-rc2
From: Kasper Sandberg <lkml@metanurb.dk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511200018.11791.gene.heskett@verizon.net>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	 <200511200018.11791.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 23:36:54 +0100
Message-Id: <1132526214.15938.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-20 at 00:18 -0500, Gene Heskett wrote:
> On Saturday 19 November 2005 22:40, Linus Torvalds wrote:
> >There it is (or will soon be - the tar-ball and patches are still
> >uploading, and mirroring can obviously take some time after that).
> 
> First breakage report, tvtime, blue screen no audio.  Trying slightly
> different .config for next build.  My tuner (OR51132) seems to be
> permanently selected in an xconfig screen.  Dunno if thats good or bad
> ATM.
if it needs to be loaded with a parameter you will need to build it as a
module.. my saa7134 chip needs card=9.

i am experiencing same problems with saa7134, no video, however i do get
audio.

this is a way to (incorrectly according to v4l devs) "fix" it:
drivers/media/video/video-buf.c
change line 1233 to this:
        vma->vm_flags |= VM_DONTEXPAND;

> 

