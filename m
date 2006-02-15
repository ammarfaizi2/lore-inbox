Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWBODSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWBODSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWBODSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:18:05 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:13264 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1030609AbWBODSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:18:04 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Date: Wed, 15 Feb 2006 03:17:56 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jan Kara <jack@suse.cz>, Nohez <nohez@cmie.com>
References: <200602100536.02893.ctpm@rnl.ist.utl.pt> <200602140616.11856.ctpm@rnl.ist.utl.pt> <20060214201946.GD20175@ca-server1.us.oracle.com>
In-Reply-To: <20060214201946.GD20175@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602150317.57250.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 14 February 2006 20:19, Mark Fasheh wrote:
>
> We have some dlm fixes in our git tree which haven't made their way to
> Linus yet (I wanted to run a few more tests). Would you be interested in
> patching with them so we can see which bugs are left? The easiest way to
> get this is to pull them out of 2.6.16-rc3-mm1:
>
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.1
>6-rc3-mm1/broken-out/git-ocfs2.patch
>

 OK, will do.

>
> Could you load up debugfs.ocfs2 against your file system and run the
> following command:
>
> debugfs: locate <M0000000000000000d4a94b05ae097f>
>
> It will tell me the path to the file which that metadata lock refers to.
> The path may help us figure out what sort of access we're having problems
> on here.

debugfs.ocfs2 1.1.5
debugfs: locate <M0000000000000000d4a94b05ae097f>
13936971        /ctpm/dir2/build-AMD-linux-2.6.16-rc2-git3-jbdfix1/drivers/media/video/cx25840/cx25840-core.c


 This is a file from the kernel build tree I untarred on node 1. So I suppose 
the other two nodes eventually were trying to read it.


Regards

Claudio

