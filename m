Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUKJBag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUKJBag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUKJBag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:30:36 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:55312 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261821AbUKJBaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:30:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rr3EcEFWzhW4oc5b3b+9/RHyb/kR5zjeEckCU5790z70KFcgLkqA1LDz6OIbKeQztD4PrzeBcMy565Gic09oCq0walXrQQC26NWRjqU/9YY4lolcEs29SbUiBKkdgNd/Rcch4OYdIdsbKzmwcJWp/9II0s1zyPS9vQ4Jn2jQKHA=
Message-ID: <21d7e997041109173053cd0605@mail.gmail.com>
Date: Wed, 10 Nov 2004 12:30:29 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Stefano Rivoir <s.rivoir@gts.it>
Subject: Re: 2.6.10-rc1-mm4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e997041109151833ef1d90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109074909.3f287966.akpm@osdl.org>
	 <200411091802.16386.s.rivoir@gts.it>
	 <21d7e997041109151833ef1d90@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> > A glxgears causes Xorg to get immediately out; nothing very notable in the
> > logs, except for
> >
> > Nov  9 17:57:09 nbsteu kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init
> > called without lock held
> > Nov  9 17:57:09 nbsteu kernel: [drm:drm_unlock] *ERROR* Process 4999 using
> > kernel context 0
> >
> > in the syslog.
> >
> > Note that everything works fine with 2.6.10-rc1-bk18.
> > Attached, lspci and .config.
> 

I've tracked it down to the Kconfig for the new DRM, I'm not sure what
to do with it, if AGP is a module then DRM needs to be a module now
not a yes.... but this probably isn't a hard dependency, i.e. it is
still legal to build DRM as a y but AGP won't be used as it is not in
the kernel.... I'm unsure how to do any sort of weak dependency in the
kernel configuration structure if it is at all possible..

Dave.
