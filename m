Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287626AbSASWxw>; Sat, 19 Jan 2002 17:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSASWxo>; Sat, 19 Jan 2002 17:53:44 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34228 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287626AbSASWxi> convert rfc822-to-8bit;
	Sat, 19 Jan 2002 17:53:38 -0500
Date: Sat, 19 Jan 2002 17:53:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
In-Reply-To: <20020119232455.D12692@unthought.net>
Message-ID: <Pine.GSO.4.21.0201191749300.5397-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Jan 2002, [iso-8859-1] Jakob Østergaard wrote:

> > All this seems very neat. One question: what about forced umount / forced
> > remount readonly stuff? Any plans on that?
> > 
> 
> That would be *very* nice indeed.  Even if it was only for things like NFS
> and SMBFS.

umount(mountpoint, MNT_DETACH);

Had been there for quite a while...

It's not a forced umount - it detaches the subtree from mountpoint and
filesystem(s) go away when they stop being busy.  But for remote
filesystems that's precisely what you want.

