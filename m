Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVBHBuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVBHBuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVBHBuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 20:50:55 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:54277 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261381AbVBHBuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 20:50:51 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Date: Tue, 8 Feb 2005 01:48:40 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cu95po$3ch$1@abraham.cs.berkeley.edu>
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us> <20050207142603.A469@build.pdx.osdl.net> <200502072241.j17MfTfP027969@turing-police.cc.vt.edu>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1107827320 3473 128.32.168.222 (8 Feb 2005 01:48:40 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Tue, 8 Feb 2005 01:48:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>For those systems that have everything on one big partition, you can often
>do stuff like:
>
>ln /etc/passwd /tmp/<filename_generated_by_mktemp>
>
>and wait for /etc/passwd to get clobbered by a cron job run by root...

How would /etc/passwd get clobbered?  Are you thinking that a tmp
cleaner run by cron might delete /tmp/whatever (i.e., delete the hardlink
you created above)?  But deleting /tmp/whatever is safe; it doesn't affect
/etc/passwd.  I'm guessing I'm probably missing something.
