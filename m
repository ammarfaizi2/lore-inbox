Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267186AbSKXJSb>; Sun, 24 Nov 2002 04:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbSKXJSb>; Sun, 24 Nov 2002 04:18:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4337 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267186AbSKXJSb>;
	Sun, 24 Nov 2002 04:18:31 -0500
Date: Sun, 24 Nov 2002 04:25:40 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [RFC] DEVFS_NOTIFY_ASYNC_OPEN removal
In-Reply-To: <Pine.GSO.4.21.0211240310120.9014-100000@steklov.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0211240422090.9014-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Nov 2002, Alexander Viro wrote:

> 	* when memory pressure finally flushes dentry of /dev/vc/<n>

Sorry -

	* when final dput() comes

(which can also happen with arbitrary delay)

Oh, and the "CLOSE" event can be lost if we are low on memory, so it's
unreliable to boot...

