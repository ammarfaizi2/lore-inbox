Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUEBOOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUEBOOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 10:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUEBOOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 10:14:19 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:17807 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S263085AbUEBOOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 10:14:18 -0400
Date: Sun, 2 May 2004 17:14:46 +0300 (EEST)
From: GNU/Dizzy <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem with multiple mount-points
In-Reply-To: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange>
Message-ID: <Pine.LNX.4.58L0.0405021712280.31153@ahriman.bucharest.roedu.net>
References: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004, Guennadi Liakhovetski wrote:

> Hi
Hi

> 
> Disclaimer: I am not a filesystem expert, so, what's below might be
> absolute nonsense.
> 
> There are systems, where it is desirable to make some partitions,
> possibly, including root, read-only, and some other, like, e.g., /var,
> /home, /lib/modules read-writable. Those writable filesystems may be quite
> small, so, putting them on separate partitions creates too much overhead
> for filesystem metadata, journals... Making those directories soft-links
> into one writable partition would work, but is not too nice.
> 
> So, how about adding a multiple mount-point option to some filesystem?
> They would share metadata, journals, would be represented by several
> directory-trees, and be mountable with, e.g.

How about mounting the big volume somewhere and using -o bind to mount 
some paths within it in different places of your needs ? I know that -o 
bind doesnt honor -o ro yet but if you really needed maybe you can make a 
patch for that, I for one would be very interested about that.
check "man mount" about more information about "bind"

Also notice that linux (starting with some 2.3.x version if I remember 
well) already supports multiple mount points for a given "source" like
mount /dev/hda1 /mnt1
mount /dev/hda1 /mnt2 and so on

-- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
