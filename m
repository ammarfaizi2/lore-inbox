Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWIFWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWIFWfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWIFWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:35:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:16307 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751764AbWIFWfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:35:32 -0400
Date: Wed, 6 Sep 2006 15:35:20 -0700
From: Greg KH <gregkh@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive	locking detected
Message-ID: <20060906223520.GA9658@suse.de>
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com> <20060905111306.80398394.akpm@osdl.org> <44FDCEAD.5070905@s5r6.in-berlin.de> <44FE751E.4030505@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FE751E.4030505@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 09:13:34AM +0200, Stefan Richter wrote:
> Do class->subsys.rwsem, bus->subsys.rwsem, and bus_type.subsys.rwsem
> point to identical or different lock instances?

class->subsys.rwsem is different from the others.  bus->subsys.rwsem and
bus_type.subsys.rwsem are probably the same thing (depending on what
that bus-> pointer is to.)

> Either way, could it hurt to convert nodemgr to uniformly use
> ieee1394_bus_type.subsys.rwsem all over the place?

Probably a good idea.

thanks,

greg k-h
