Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbTACHRH>; Fri, 3 Jan 2003 02:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTACHRH>; Fri, 3 Jan 2003 02:17:07 -0500
Received: from havoc.daloft.com ([64.213.145.173]:32917 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267445AbTACHRH>;
	Fri, 3 Jan 2003 02:17:07 -0500
Date: Fri, 3 Jan 2003 02:25:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Deprecate exec_usermodehelper, fix request_module.
Message-ID: <20030103072532.GA11023@gtf.org>
References: <20030103050859.4E01B2C070@lists.samba.org> <200301031722.03325.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301031722.03325.bhards@bigpond.net.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 05:21:57PM +1100, Brad Hards wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 3 Jan 2003 16:08, Rusty Russell wrote:
> > + * Must be called from process context.  Returns a negative error code
> > + * if program was not execed successfully, or (exitcode << 8 + signal)
> > + * of the application (0 if wait is not set).
> Any chance that you can remove this (existing) restriction. It'd be good to be 
> able to use this in some networking code (eg netif_carrier_[off|on]() ), but 
> that might be in interrupt context.

The link up/down notifications added in recent 2.5.x should eliminate a
need to fiddle while in interrupt context...

