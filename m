Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTKHWNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 17:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTKHWNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 17:13:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:1670 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262126AbTKHWNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 17:13:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 8 Nov 2003 14:12:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Larry McVoy <lm@work.bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Weird ext2 problem in 2.4.18 (redhat)
In-Reply-To: <20031108164410.GB2955@thunk.org>
Message-ID: <Pine.LNX.4.44.0311081405080.2122-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Nov 2003, Theodore Ts'o wrote:

> Sounds like there is a two directory entries with the same name in the
> same directory.  This can cuase severe confusion since the kernel
> assumes that this will never happen.  Depending on which one gets
> found first, and what is cached in the dentry cache, you'll get one
> inode or the other.

It seems they've two different names "src" and " src" and ext2_match() 
should not be fooled by the space. If this is the drive that has been 
hacked, I'd rather go for a full cleanup.



- Davide


