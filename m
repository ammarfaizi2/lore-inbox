Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276343AbRJCPIe>; Wed, 3 Oct 2001 11:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276349AbRJCPIY>; Wed, 3 Oct 2001 11:08:24 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:27397 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S276343AbRJCPIQ>; Wed, 3 Oct 2001 11:08:16 -0400
Date: Wed, 3 Oct 2001 11:08:41 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20011003110841.A5006@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921162949.H8188@mueller.datastacks.com> <20010926223814.A169@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010926223814.A169@bug.ucw.cz>; from pavel@suse.cz on Wed, Sep 26, 2001 at 10:38:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 26/09/01 22:38 +0200 - Pavel Machek:
> Hi!
> 
> > > 2.  I'd really prefer to see callers use
> > > register_sysrq_key() and unregister_sysrq_key() so that they
> > > can get/use return values, and not the lower-level functions
> > > "__sysrq*" functions that are EXPORTed in sysrq.c.
> > > I don't see a good reason to EXPORT all of these functions.
> > 
> > So would I, however, the lower interface is there so that modules can
> > restructure the table in more complex ways, allowing for sub-menus.
> 
> This is kernel, and sysrq was designed to be debug tool. It turned out
> to be more successfull than expected...
> 
> Just keep in mind its a debug tool. If you need hierarchical submenus,
> then you are probably not using it as debug tool, right?
> 								Pavel

Wrong. If I have heirarchal menus, then I can have debug code for many
parts of the kernel, and _detailed_ debug code for any given part, in
the sysrq handlers simultaneously.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
