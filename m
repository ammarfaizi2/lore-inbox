Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129731AbQJ3XZX>; Mon, 30 Oct 2000 18:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbQJ3XZF>; Mon, 30 Oct 2000 18:25:05 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:517 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129199AbQJ3XZC>; Mon, 30 Oct 2000 18:25:02 -0500
Date: Mon, 30 Oct 2000 23:24:57 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: / on ramfs, possible?
In-Reply-To: <8tj899$dqg$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.21.0010302323490.16101-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Oct 2000, H. Peter Anvin wrote:

> > I want my / to be a ramfs filesystem. I intend to populate it from an 
> > initrd image, and then remount / as the ramfs filesystem. Is that at 
> > all possible? The way I see it the kernel requires / on a device 
> > (major,minor) or nfs.
> > 
> > Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?
> > 
> 
> Use pivot_root instead of the initrd stuff in /proc/sys.

Urgh. Then you're still using an initrd, and you still have to include all
the crap necessary to support those horrid block-device thingies. 

Why not just use a ramdisk?

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
