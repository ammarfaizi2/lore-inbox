Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbQKPXlR>; Thu, 16 Nov 2000 18:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131565AbQKPXlH>; Thu, 16 Nov 2000 18:41:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34491 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131507AbQKPXlB>;
	Thu, 16 Nov 2000 18:41:01 -0500
Date: Thu, 16 Nov 2000 18:10:59 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <8v1ng9$omi$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0011161801380.13047-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Nov 2000, H. Peter Anvin wrote:

[hardlinks on directories]

> I don't believe it's inherently impossible in Linux anymore.  In fact,

Yes, it is. bindings are asymmetrical. And that's the reason why they
work while links to directories do not. 

> vfsbinds provide a lot of the same kind of functionality; the main
> difference between vfsbinds and hard links are that the former (a) can
> cross filesystem boundaries and (b) aren't persistent.

Here's one more: you can't rename across the binding boundary. They _are_
mounts, so they avoid all that crap with loop creation on rename, etc.
Take a generic DAG and try to implement rename() analog on it. Have fun
catching the cases that would make the graph disconnected.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
