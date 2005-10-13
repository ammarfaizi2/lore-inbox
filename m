Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVJMAJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVJMAJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVJMAJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:09:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:1506 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S964823AbVJMAJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:09:35 -0400
Date: Thu, 13 Oct 2005 01:09:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jeff Mahoney <jeffm@suse.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051013000921.GD23770@mail.shareable.org>
References: <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com> <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> But discarding data sometimes on USB unplug is even worse than discarding 
> data always --- users will by experimenting learn that linux doesn't 
> discard write-cached data and reminds them to replug the device --- and 
> one day, randomly, they lose their data because of some memory management 
> condition...

It should not happen provided the total amount of dirty data for
detachable devices is restricted to allow enough room for opening a
dialog.

That's no different, in principle, than the restrictions that are used
to ensure some types of kernel memory allocation always succeed.

There's no exact calculation, just a notion of "this many megabytes
should be enough for a dialog".

-- Jamie
