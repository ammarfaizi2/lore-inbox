Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWGaJGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWGaJGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWGaJGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:06:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:3925 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751489AbWGaJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:06:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=ECUStoPM59fnvt4XS3dceDHogG1VtREUzZn1mdSBliBagvcavK61vMVCqwP6czhFuMWtrJGt1xaPGBx1bhDi778MJtOoi4Xjx+m8wKbz2IzEfvS/rqLBXvpOheOEfHPejxjnC1TylHHYRccdCH+/vjQbvqsco2PlV1N086vALmE=
Date: Tue, 1 Aug 2006 11:06:47 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Masatake YAMATO <jet@gyve.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, acme@mandriva.com,
       marcel@holtmann.org
Subject: Re: [01/04 mm-patch, rfc] Add lightweight rwlock
Message-ID: <20060801090647.GA920@slug>
References: <20060728123246.GB311@slug> <20060728.221252.265353941.jet@gyve.org> <20060728161515.GA1227@slug> <20060731.160615.122996450.jet@gyve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731.160615.122996450.jet@gyve.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 04:06:15PM +0900, Masatake YAMATO wrote:
Hi,
> > The following set of patches adds a struct lw_rwlock (for lightweight
> > rwlock) which contains a spin_lock_t and an atomic_t. It is defined
> > in include/linux/lw_rwlock.h.
> 
> I think the name, "lightweight" is too generic. 
Fair enough.
> It implies just lw_rwlock is better than rwlock. The name may lead that people 
> use lw_rwlock rather than rwlock any place through there are places where 
> rwlock is better than lw_rwlock. So I looked for the name:
> 
> sw_rwlock: seldom writing rwlock
> wp_rwlock: write pricey rwlock

write expensive, we_rwlock? I like your idea of stressing the fact that
the protected data has to be seldom modified if you intend to use this
kind of lock.

> rp_rwlock: read prioritized rwlock
> 
I'll re-submit the patch with a proper naming for the rc3-mm1. However, I'd
like to get some feedback on the code itself: the current
whatever_rwlock code won't be debuggable with lockdep, and I'm not sure
there's not some more clever way to do it.

Thanks,
Frederik
