Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVC3VCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVC3VCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVC3VAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:00:39 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:4574 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261686AbVC3U6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:58:53 -0500
Date: Wed, 30 Mar 2005 22:58:37 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc1-mm3] BUG: atomic counter underflow in smbfs
Message-ID: <20050330205837.GF10278@ens-lyon.fr>
References: <20050330201818.GA18967@ens-lyon.fr> <20050330124456.3da2a2b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330124456.3da2a2b8.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 12:44:56PM -0800, Andrew Morton wrote:
> Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> >
> > I had the following BUG with 2.6.12-rc1-mm3:
> > 
> > remote host is running 2.6.12-rc1-mm1 with samba 3.0.13.
> > 
> > [23156.357178] smb_lookup: find musique/Pink_Floyd-Dark_Side_of_the_Moon
> > failed, error=-512
> > [23157.057501] BUG: atomic counter underflow at:
> > [23157.057508]  [<c0103c27>] dump_stack+0x17/0x20
> > [23157.057516]  [<e0ed0f31>] smb_rput+0x51/0x60 [smbfs]
> > [23157.057530]  [<e0ecd497>] smb_proc_query_cifsunix+0x77/0xa0 [smbfs]
> > [23157.057538]  [<e0eca14c>] smb_newconn+0x2bc/0x310 [smbfs]
> > [23157.057546]  [<e0ed05ac>] smb_ioctl+0xfc/0x100 [smbfs]
> > [23157.057554]  [<c0162188>] do_ioctl+0x48/0x70
> > [23157.057559]  [<c01622f9>] vfs_ioctl+0x59/0x1b0
> > [23157.057563]  [<c0162489>] sys_ioctl+0x39/0x60
> > [23157.057582]  [<c0102d8f>] sysenter_past_esp+0x54/0x75
> 
> Oh dear.  That warning is not necessarily telling us that there's a serious
> problem - often it's fairly harmless.  Did the filesytem misbehave in any
> other manner?
> 
It was stucked (couldn't do anything inside) but i was able to umount
it.

> A problem we have here is that nobody really maintains smbfs any more, and
> it has problems.  I was hoping that the stock answer to that would be "use
> cifs", but for some reason that doesn't seem to be happening.  Have you
> tried it?  (Last time I looked, cifs didn't work against win98 servers -
> maybe that got fixed).
> 
> 
Ok, i think i will google a bit to find how to use samba as a cifs server.

Thanks,

Benoit

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
