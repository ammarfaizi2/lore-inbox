Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265491AbTIJSye (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbTIJSye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:54:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:22976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265491AbTIJSya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:54:30 -0400
Date: Wed, 10 Sep 2003 11:54:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Stephen Hemminger <shemminger@osdl.org>, <jffs-dev@axis.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
In-Reply-To: <20030910181847.GO454@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0309101152060.25211-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Sep 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> JFFS is host-endian.  If you want to make it swing both ways - feel free,

Please don't.

Dual-endianness is _evil_.

Admittedly host-endian is stupid too, but it's less stupid than being 
dual.

The only sane thing to do is fixed-endianness. I'm sure the m68k people 
remember being forced to fix their ext2 partitions back in the bad old 
days. It's painful once, but after that, fixed-endian is a lot more 
efficient and much simpler to handle.

		Linus

