Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRJKBrl>; Wed, 10 Oct 2001 21:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275570AbRJKBrZ>; Wed, 10 Oct 2001 21:47:25 -0400
Received: from www.inreko.ee ([195.222.18.2]:28131 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S275265AbRJKBrK>;
	Wed, 10 Oct 2001 21:47:10 -0400
Date: Thu, 11 Oct 2001 04:04:25 +0200
From: Marko Kreen <marko@l-t.ee>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11: mount flag noexec still broken for VFAT partition
Message-ID: <20011011040424.A19996@l-t.ee>
In-Reply-To: <Pine.LNX.4.21.0110102258290.28429-100000@gulbis.latnet.lv> <20011010151333.G10443@turbolinux.com> <20011011003609.B18573@l-t.ee> <9q2rhn$77i$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9q2rhn$77i$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 06:10:15PM -0700, H. Peter Anvin wrote:
> Followup to:  <20011011003609.B18573@l-t.ee>
> By author:    Marko Kreen <marko@l-t.ee>
> In newsgroup: linux.dev.kernel
> > 
> > Um.  'noexec' does not touch flags, it only disallows exec'ing
> > on particular mountpoint.
> > 
> 
> It does on FAT filesystems (except UMSDOS), since they don't have real
> flags.  Files and directories have syntesized attributes of
> (0777 & ~umask); noexec is supposed to modify that to (0666 & ~umask)
> for files but not directories.
> 
> That has been the Linux behaviour since the 0.x days.

Eh.  Seems my brain has managed to filter that out thus far.
Probably as "uninteresting" is the only thing I can say :)

What is interesting is that in current vfat I can toggle
+x bit on and off with chmod.  So it seems like VFS does
not consult with fs anymore about bits.  But you know
that already.

Oh well...

-- 
marko

