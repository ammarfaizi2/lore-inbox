Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWCEOJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWCEOJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 09:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWCEOJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 09:09:35 -0500
Received: from ns.suse.de ([195.135.220.2]:62693 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932106AbWCEOJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 09:09:34 -0500
Date: Sun, 5 Mar 2006 15:09:32 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060305140932.GA17132@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Feb 26, Linus Torvalds wrote:

> Have I missed anything? Holler. And please keep reminding about any 
> regressions since 2.6.15.

I see random memory corruption on an early G3 ibook.
Testcase is an openSuSE 10.1 installation. 2.6.15 works ok modulo 2 bugs
to get it booted at all, and the usual udev breakage.

plain 2.6.16-rc5-git7 locks up after a few packages, no ping.
Our SuSE kernel does not lockup, but ext2 shows access beyond end of
device after > 200 packages, or the rpmdb gets corrupt, or both. With reiserfs
it gets past 100 packages, then reiserfs complains about fs corruption.
plain -rc2 shows the same reiserfs corruption.
plain -rc1 dies after a few packages, it jumps to 0x0 in softirq.

I'm trying to compile the git snapshots now, which is a real challenge..
