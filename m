Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVJNRCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVJNRCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVJNRCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:02:05 -0400
Received: from mail.shareable.org ([81.29.64.88]:26851 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1750798AbVJNRCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:02:02 -0400
Date: Fri, 14 Oct 2005 17:52:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jeff Mahoney <jeffm@suse.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051014165223.GA23420@mail.shareable.org>
References: <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com> <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz> <20051013111707.GB516@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013111707.GB516@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> *Good starting point*.
> 
> Anyway, one solution would be to simply mlockall() on that replugitd

Unfortunately, mlockall() isn't effective for an X application (for
the dialog) because the X server needs resources too, and that's not
usually mlock'd because it's too big.  (It would be nice to have a
general solution to allow mlock'd GUI applications).

> and/or make dirty data hdd based (not ram based)

Ooh, swappable dirty data... nice idea :)

> and/or restricting dirty buffers to 10MB for removable media.

That seems like the simplest effective solution.

-- Jamie
