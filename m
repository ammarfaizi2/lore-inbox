Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVDEJ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVDEJ04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVDEJ0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:26:54 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:54300 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbVDEJZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:25:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bzFaE111bZCHGDFd1LyAwntz6zDS/Ja1u2tVym7kkna2JyX1uLzkLI42B2NFSfFJKg8IqbzAIJI1yAli60Row5Az2gY041b0jz4ct5bONlLwTP/l0aTe7yJSjgY8R3sfGjA+Exbx3tgnIB89a0y9JxSOBfWBU3t8Tr4Pt06i4Bo=
Message-ID: <21d7e997050405022560e3f62f@mail.gmail.com>
Date: Tue, 5 Apr 2005 19:25:10 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.12-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405000524.592fc125.akpm@osdl.org>
	 <20050405074405.GE26208@infradead.org>
	 <21d7e99705040502073dfa5e5@mail.gmail.com>
	 <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Paulus these look like your patches care to update them with the "new"
> > method of doing stuff..
> 
> What are we going to do about the DRM CVS?  Change it to the new way
> and break everyone running 2.6.10 or earlier, or leave it at the old
> way that will work for people with distro kernels, and have a
> divergence between it and what's in the kernel?

Yet more backwards compatibility is more than likely going to be
needed, but if it is a biggie I'd be happy to drop the older 32/64-bit
stuff from CVS and make it contingent on having 2.6.11 or greater as
it is a new feature anyways and hasn't seen a release yet...

> 
> Also, the compat_ioctl method is called without the BKL held, unlike
> the ioctl method.  What impact will that have?  Do we need to take the
> BKL in the compat_ioctl method?

I don't think so as the DRM has its own locking that handles most of
the issues at a higher level... I've been thinking of switching DRM to
ioctl_unlocked but I'd really want someone with an SMP system to beat
on it .. (not that the DRI has a great record on SMP anyways..)

Dave.

Dave.
