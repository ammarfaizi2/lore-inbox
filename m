Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVAHNmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVAHNmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVAHNmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:42:07 -0500
Received: from mproxy.gmail.com ([216.239.56.241]:64197 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261159AbVAHNmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:42:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hLGtuTLUzAP+M1z21jyrYQC3fAG7IYGhdGOUcBoHcbF2XNL9SneoJ/doaG9miPNc9bglUjrnByljguNJ7eB2LHvvqUwHavc0Uy2DBW35Rot2gXzsXvqsDoVAmS/W+gpRU9iDnFnTLqKUEAD0iwuwaH88Y8P5D35oNQP0s+ndXPY=
Message-ID: <21d7e99705010805424ec16550@mail.gmail.com>
Date: Sun, 9 Jan 2005 00:42:03 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, Mike Werner <werner@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40f323d00501080427f881c68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <21d7e99705010718435695f837@mail.gmail.com>
	 <40f323d00501080427f881c68@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > >
> > > [drm:drm_unlock] *ERROR* Process 10657 using kernel context 0
> > >
> >
> > this looks like the agp backend isn't loading, Mike sent me parts of
> > your .config but I lost the mail (don't drink and read e-mail...)
> >
> 

it looks like agp_backend_acquire is returning NULL in this case, 
[drm:drm_ioctl] pid=10587, cmd=0x6430, nr=0x30, dev 0xe200, auth=1
[drm:drm_ioctl] ret = ffffffed
is the agp acquire ioctl and the return is -ENODEV 

Any ideas Mike why that might happen?

Dave.
