Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287500AbSAEELx>; Fri, 4 Jan 2002 23:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSAEELn>; Fri, 4 Jan 2002 23:11:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46554 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287500AbSAEEL2>;
	Fri, 4 Jan 2002 23:11:28 -0500
Date: Fri, 4 Jan 2002 23:11:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [FIX] missing piece from fs/super.c in -pre8
In-Reply-To: <Pine.GSO.4.21.0201042302410.27334-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0201042307430.27334-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Alexander Viro wrote:

> 	/me scratches head wondering how the ^*#! did it manage to disappear
> from the version of patch sent to Linus...

After another look...  I see what had happened, but...

Linus, I doubt that making the thing inline was a good idea.  Reason: for
filesystems like NFS we almost definitely want something like server name
+ root path to identify the superblock.  And that can easily grow past
32 bytes.

