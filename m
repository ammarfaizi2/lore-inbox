Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312495AbSCUVIf>; Thu, 21 Mar 2002 16:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSCUVIZ>; Thu, 21 Mar 2002 16:08:25 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:55440
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S312495AbSCUVIK>; Thu, 21 Mar 2002 16:08:10 -0500
Date: Thu, 21 Mar 2002 14:03:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020321210356.GI25237@opus.bloom.county>
In-Reply-To: <3C985A46.D3C73301@aitel.hist.no> <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home> <a7dev9$n51$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 12:14:33PM -0800, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.44.0203200943230.3615-100000@xanadu.home>
> By author:    Nicolas Pitre <nico@cam.org>
> In newsgroup: linux.dev.kernel
> >
> > On Wed, 20 Mar 2002, Helge Hafting wrote:
> > 
> > > Nicolas Pitre wrote:
> > > 
> > > > > Removable media?
> > > > 
> > > > Most if not all removable media are not ment to be used with JFFS2.
> > > 
> > > Nothing is _meant_ to be exploited either.  Someone could
> > > create a cdrom with jffs2 (linux don't demand that cd's use iso9660)
> > 
> > But JFFS2 demands to be used with AN MTD device, not a block device.  And
> > most MTD device, if not all of them, on which JFFS2 is used aren't
> > removable.
> 
> Isn't this whole discussion a bit silly?  If I'm not mistaken, we're
> talking about a one-line known fix here...

It's getting there.  The 'issue' is that the best way to fix it (maybe
2.4.20-pre1 even) is to backport the 2.5 zlib which doesn't have this
problem and removes most of the copies of zlib from the kernel.  If it's
not really a problem now, why fix it?  (Tho it should be a safe fix now
that Paul has produced a patch which doesn't suffer from random oopses
or other problems).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
