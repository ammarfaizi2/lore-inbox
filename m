Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274808AbRJKBKb>; Wed, 10 Oct 2001 21:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJKBKU>; Wed, 10 Oct 2001 21:10:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56840 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274808AbRJKBKJ>; Wed, 10 Oct 2001 21:10:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.11: mount flag noexec still broken for VFAT partition
Date: 10 Oct 2001 18:10:15 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9q2rhn$77i$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0110102258290.28429-100000@gulbis.latnet.lv> <20011010151333.G10443@turbolinux.com> <20011011003609.B18573@l-t.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011011003609.B18573@l-t.ee>
By author:    Marko Kreen <marko@l-t.ee>
In newsgroup: linux.dev.kernel
> 
> Um.  'noexec' does not touch flags, it only disallows exec'ing
> on particular mountpoint.
> 

It does on FAT filesystems (except UMSDOS), since they don't have real
flags.  Files and directories have syntesized attributes of
(0777 & ~umask); noexec is supposed to modify that to (0666 & ~umask)
for files but not directories.

That has been the Linux behaviour since the 0.x days.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
