Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbTDAOET>; Tue, 1 Apr 2003 09:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262539AbTDAOET>; Tue, 1 Apr 2003 09:04:19 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5023 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262536AbTDAOET>; Tue, 1 Apr 2003 09:04:19 -0500
Date: Tue, 1 Apr 2003 15:17:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ed Tomlinson <tomlins@cam.org>
cc: CaT <cat@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <20030401133833.6C71DF3D@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.44.0304011506150.1294-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Ed Tomlinson wrote:
> 
> What does tmpfs have to do with ram size?  Its swappable.  This _might_ be
> useful for ramfs but for tmpfs, IMHO, its not a good idea.

The default size of a tmpfs filesystem is 50% of RAM.  That can be
overridden by setting the size explicitly, CaT is offering percent
instead.  Which is nice, and neatly done.

But I do agree with you that it seems a bit strange, not to take
swap into account at all.  That's one reason I never bothered to
add the feature CaT proposes before.  Just imagine you keep swap
at some % of your RAM, then it'll all scale together.

Hugh

