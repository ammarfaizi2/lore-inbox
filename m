Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTKKHXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbTKKHXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:23:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:45187 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264266AbTKKHXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:23:11 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 23:22:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: walt <wa1ter@myrealbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FB05EDE.6090007@myrealbox.com>
Message-ID: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, walt wrote:

> Andrea Arcangeli wrote:
> 
> >>On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
> > The best way to fix this isn't to add locking to rsync, but to add two
> > files inside or outside the tree, each one is a sequence number, so you
> > fetch file1 first, then you rsync and you fetch file2, then you compare
> > them. If they're the same, your rsync copy is coherent. It's the same
> > locking we introduced with vgettimeofday...
> 
> How is this different from writing one file named LOCK while updating
> the tree?

This is even simpler I believe. If you happen to fetch it, you restart the 
rsync. Peter ?
(maybe the name LOCK should be replaced by something more "uniq")



- Davide



