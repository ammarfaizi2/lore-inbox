Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVLDQXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVLDQXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLDQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:23:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:59800 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932269AbVLDQXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:23:38 -0500
X-Authenticated: #428038
Date: Sun, 4 Dec 2005 17:23:36 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204162336.GD17846@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org> <20051204142551.GB4769@merlin.emma.line.org> <1133709649.5188.54.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133709649.5188.54.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005, Arjan van de Ven wrote:

> >  (C) Copyright notice and "All rights reserved."
> > 
> > > > These use inter_module_get() 
> > > 
> > > which is still there even in the latest 2.6.15-rc. It should be going
> > > out but hasn't yet. And that is the case for at least a year (eg they
> > > are __deprecated but still there).
> > 
> > No, they aren't - at least not anywhere declared below include/ and thus
> > uncompilable with GCC4.
> 
> # pwd
> /mnt/raid/linux/linux-2.6.15-rc4/include/linux
> [root@jackhammer linux]# grep inter_mod *
> module.h:extern void __deprecated inter_module_register(const char *,
> module.h:extern void __deprecated inter_module_unregister(const char *);
> module.h:extern const void * __deprecated inter_module_get_request(const
> char *,
> module.h:extern void __deprecated inter_module_put(const char *);

Same story with -rc5. As you can see, there is no declaration for
inter_module_get(), just the _request() variant.  So what now?  :-P

-- 
Matthias Andree
