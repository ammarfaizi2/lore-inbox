Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTALJTD>; Sun, 12 Jan 2003 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbTALJTD>; Sun, 12 Jan 2003 04:19:03 -0500
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:15534 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267338AbTALJTB>; Sun, 12 Jan 2003 04:19:01 -0500
Date: Sun, 12 Jan 2003 04:27:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: two more oddities with the fs/Kconfig file
In-Reply-To: <20030112073406.GM21826@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0301120427170.4821-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Adrian Bunk wrote:

> On Sun, Jan 12, 2003 at 02:07:13AM -0500, Robert P. J. Day wrote:
> > 
> >   there are a few options that are categorized as simply
> > "bool", with no following label -- examples being UMSDOS,
> > QUOTACTL, and a couple of others.  without a label on that
> > line, the option is not displayed for selection anywhere
> > on the menu.  is this deliberate?
> >...
> 
> Yes, this is what was called define_bool in the old kconfig.
> 
> E.g.
> 
> config QUOTACTL
>         bool
>         depends on XFS_QUOTA || QUOTA
>         default y
> 
> says that QUOTACTL is automatically selected if XFS_QUOTA or QUOTA is 
> selected. This is a config option that is never visible to the user 
> configuring the kernel.

ah, and the same would apply to those options categorized as
"tristate", with no label then?  thanks.

rday

