Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVAWXc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVAWXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVAWXc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:32:56 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:15632 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261381AbVAWX0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 18:26:53 -0500
Date: Mon, 24 Jan 2005 00:26:49 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
Message-ID: <20050123232649.GA24723@pclin040.win.tue.nl>
References: <20050121141106.GG7147@wiggy.net> <20050122212328.GC11170@pclin040.win.tue.nl> <20050123225628.GA27675@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123225628.GA27675@wiggy.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 11:56:28PM +0100, Wichert Akkerman wrote:

> > Are you still able to examine the situation?
> 
> No, but I do have some more information. A e2fsck run on that filesystem
> was just as interesting:
> 
> /dev/md4: clean, 16/132480 files, -15514/264960 blocks
> 
> Forcing an e2fsck revelated a few groups with incorrect block counts:
> 
> Free blocks count wrong for group #2 (34308, counted=32306).
> Free blocks count wrong for group #6 (45805, counted=32306).
> Free blocks count wrong for group #8 (14741, counted=2354).
> Free blocks count wrong (280474, counted=252586).
> 
> After fixing those everything returned to normal. I did run dumpe2fs
> on the filesystem, if that is interesting I can retrieve and post that.

It is an interesting situation, but probably there is not enough
information to find out what happened. On the other hand, if your
dumpe2fs output is not too big you might as well post it.

Andries
