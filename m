Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTKJRzl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTKJRzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:55:41 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:52619 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264035AbTKJRzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:55:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 09:54:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Larry McVoy <lm@bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031110165738.GD6834@x30.random>
Message-ID: <Pine.LNX.4.44.0311100952280.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Andrea Arcangeli wrote:

> the updates shows up on kernel.org, rsync can't even hang on per-file
> locks, sure it can't be coherent as a whole.
> 
> The best way to fix this isn't to add locking to rsync, but to add two
> files inside or outside the tree, each one is a sequence number, so you
> fetch file1 first, then you rsync and you fetch file2, then you compare
> them. If they're the same, your rsync copy is coherent. It's the same
> locking we introduced with vgettimeofday.
> 
> Ideally rsync could learn to check the sequence numbers by itself but I
> don't mind a bit of scripting outside of rsync.

Wouldn't a simpler  "stop-rsync -> update-root -> start-rsync" work? If 
you'll hit an update you will get a error from your local rsync, that will 
let you know to retry the operation.



- Davide


