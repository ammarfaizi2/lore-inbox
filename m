Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbULOWeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbULOWeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbULOWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:33:59 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:55859 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262519AbULOWdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:33:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DOhmE2AwskKbgZue1rbL2d9C2gO/hUa8Jr5FwlPoHyMoU0uA2bwXS9F2ATAcNkJY64us85MxxlXSCQG7FLg3p1rKBOdVR+4251bSFQxsGksixdTmjX3sCAYp+Fhd0A9eYe+uSX1i0UuafuYg4FeEOwg8CHO7kUTGbKBNR9muNHw=
Message-ID: <21d7e9970412151433443c746b@mail.gmail.com>
Date: Thu, 16 Dec 2004 09:33:46 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0412151830270.3267-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041215175805.GA9207@kroah.com>
	 <Pine.LNX.4.44.0412151830270.3267-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Which would suggest some kind of refcounting bug in drivers/char/drm/,
> > > such that the reserved pages get unreserved and freed before their
> > > last unmap.  I've started looking for that, but drivers/char/drm/ is
> > > unfamiliar territory to me, so I'd be glad for someone to beat me to it.
> ...

What's the chip? Radeon IGP by any chance, as these are shared memory
chips I wonder have we missed something in the drm... also what X
release....

Nothing obvious is jumping out at me from the code that is in that
tree, it was with -mm I'd wonder but with stock kernel there is
nothing that should have changed greatly...

Dave.
