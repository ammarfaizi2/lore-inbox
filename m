Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbTDAQcV>; Tue, 1 Apr 2003 11:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbTDAQcU>; Tue, 1 Apr 2003 11:32:20 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:28496 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262689AbTDAQcT>; Tue, 1 Apr 2003 11:32:19 -0500
Date: Tue, 1 Apr 2003 17:45:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Rohland <cr@sap.com>
cc: tomlins@cam.org, CaT <cat@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <ovk7eekwsc.fsf@sap.com>
Message-ID: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Christoph Rohland wrote:
> On Tue, 01 Apr 2003, Ed Tomlinson wrote:
> > What does tmpfs have to do with ram size?  Its swappable.  This
> > _might_ be useful for ramfs but for tmpfs, IMHO, its not a good
> > idea.
> 
> I agree and I think if you add this option it should adjust to a
> percentage of (ram + swap). With this it would be a really nice
> improvement.
> I even had patches for this but to do it efficently you would need to
> add some hooks to swapon and swapoff.

You surprise me, Christoph, I'd expected you to approve of CaT's.

If tmpfs already defaulted to 50% of ram+swap, then I'd agree
with you.  But it has all along been in terms of RAM, so I think
it's better to continue in that way.  (We could add options to
allow +swap in too, but I'm not terribly interested.)

If people really wanted their tmpfs pages to go out to disk, I think
they'd be choosing a more sophisticated filesystem to manage that:
swap is a vital overflow area for tmpfs, not its home.

Hugh

