Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319771AbSINJyi>; Sat, 14 Sep 2002 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319814AbSINJyi>; Sat, 14 Sep 2002 05:54:38 -0400
Received: from fungus.teststation.com ([212.32.186.211]:20742 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S319771AbSINJyh>; Sat, 14 Sep 2002 05:54:37 -0400
Date: Sat, 14 Sep 2002 11:58:28 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D811363.70ABB50C@digeo.com>
Message-ID: <Pine.LNX.4.44.0209141111320.32154-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Andrew Morton wrote:

> But it's the same story: the requirements of
> 
> a) non blocking local IO daemon and
> 
> b) assured pagecache takedown
> 
> are conflicting.  You need at least one more thread, and locking
> against userspace activity.

I see no problem with adding another thread to handle the breaks.

Only the cost of an extra thread and the fact that smbiod was originally
created to handle the break (with a thought to eventually make it do the
IO as it does now) makes me want to put it in smbiod.

/Urban

