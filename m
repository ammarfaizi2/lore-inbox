Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSHSJdr>; Mon, 19 Aug 2002 05:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318217AbSHSJdr>; Mon, 19 Aug 2002 05:33:47 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:28428 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318215AbSHSJdr>; Mon, 19 Aug 2002 05:33:47 -0400
Date: Mon, 19 Aug 2002 11:37:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200208190048.g7J0mGW12548@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208191121530.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Aug 2002, Richard Gooch wrote:

> > > > In the "devfs=only" case, where is the module count incremented, when a
> > > > block device is opened?
>
> I've already told you about fops_get(). And for a block device, it's
> def_blk_fops.open().

Which basically calls block_dev.c:do_open() and the module count there is
only incremented if get_blkfops() is successfull, which is a dummy in this
case. So where again is the module count incremented?

> I've fixed that in my tree,
> by using devfs_get_ops(), which safely handles this. I've also added
> some comments, to make it clearer.

You never answered my question, why you insist on managing the ops
pointer. The far easier fix would be to simply remove this nonsense.

bye, Roman

