Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUEBR7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUEBR7f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUEBR7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 13:59:32 -0400
Received: from pop.gmx.de ([213.165.64.20]:41154 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263184AbUEBR7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 13:59:22 -0400
X-Authenticated: #20450766
Date: Sun, 2 May 2004 19:58:46 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, GNU/Dizzy <dizzy@roedu.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Filesystem with multiple mount-points
In-Reply-To: <20040502162842.GX17014@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0405021951100.2613-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> <shrug>
>
> mount <whatever> /tmp/blah
> mount --bind /tmp/blah/relative_path /desired_mountpoint
> umount -l /tmp/blah

Wow! I, actually, thought about it, but I didn't expect it to work right
now, I would expect the umount to fail with EBUSY... But it does work!
Guys, it rocks! The only slight inconvenience - mount still shows

/tmp/blah/relative_path /desired_mountpoint (bind)

which is not necessarily informative. A better display would be, perhaps

<whatever>:relative_path /desired_mountpoint (bind)

in /proc/mounts also not quite true:

<whatever> /desired_mountpoint

One might want to improve those...

Thanks
Guennadi
---
Guennadi Liakhovetski


