Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTABA3y>; Wed, 1 Jan 2003 19:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbTABA3y>; Wed, 1 Jan 2003 19:29:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42506 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265373AbTABA3x>; Wed, 1 Jan 2003 19:29:53 -0500
Date: Wed, 1 Jan 2003 16:32:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
In-Reply-To: <20030101235842.A3044@infradead.org>
Message-ID: <Pine.LNX.4.44.0301011631090.12809-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Jan 2003, Christoph Hellwig wrote:
> 
> I can add an empty stub function, but that doesn't help to reduce the
> ifdef mess as there is no /proc/<pid>/maps on nommu at all so we don't
> have the struct file_operations and more important can't register it.

So change it. I'd rather have an empty /proc/pid/maps than have the 
general code have #ifdef's.

Or make /proc more dynamic, although I don't think it's necessarily worth
it unless it would be part of a generic dentry'ification (the devfs work 
is all well and good, but /proc has been around even longer).

		Linus

