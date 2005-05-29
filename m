Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVE2HLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVE2HLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 03:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVE2HLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 03:11:25 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:48523 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261260AbVE2HLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 03:11:22 -0400
Date: Sun, 29 May 2005 08:11:17 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Dave Jones <davej@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
In-Reply-To: <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>
Message-ID: <Pine.LNX.4.58.0505290809180.9971@skynet>
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com>
 <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> >
> > The whole dependancy seems like nonsense to me.
> > I think
> >
> >     depends on PCI
> >
> > is a lot more sensible.
>
> I think the original reasoning was something like this:
>
> If DRM is built-in, then AGP _must_ be built-in or not included at all,
> modular
> won't work.  If DRM is modular or not built, then AGP may be built-in,
> modular,
> or not built at all.
>
> The "depends on AGP || AGP=n" means that if DRM=y, then AGP=y or AGP=n, and if
> DRM=m or DRM=n, then AGP=y or AGP=m or AGP=n.
>
> Yes it's unclear and yes it should probably be documented in a comment
> somewhere.

What Kyle said is the correct answer... we either keep this lovely
construct (I'll add a comment for 2.6.13) or we go back to the old
intermodule or module_get stuff... DRM built-in with modular AGP is always
wrong... or at least I'll get a hundred e-mails less every month if I
say it is ..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

