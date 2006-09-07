Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWIGLNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWIGLNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWIGLNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:13:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17417 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751672AbWIGLNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:13:31 -0400
Date: Thu, 7 Sep 2006 13:13:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olaf@aepfle.de>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols (v2)
Message-ID: <20060907111329.GI25473@stusta.de>
References: <44FFEE5D.2050905@openvz.org> <20060907110513.GA22319@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907110513.GA22319@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 01:05:13PM +0200, Olaf Hering wrote:
> On Thu, Sep 07, Kirill Korotaev wrote:
> 
> > At stage 2 modpost utility is used to check modules.
> > In case of unresolved symbols modpost only prints warning.
> > 
> > IMHO it is a good idea to fail compilation process in case of
> > unresolved symbols (at least in modules coming with kernel),
> > since usually such errors are left unnoticed, but kernel
> > modules are broken.
> 
> It clearly depends on the context. An unimportant dvb module may have
> unresolved symbols, but the drivers for your root filesystem should
> rather not have unresolved symbols.
> 
> Better leave the current default, your patch seems to turn an unresolved
> symbol with "unknown importance" into a hard error.

If any module shipped with the kernel has in any configuration 
unresolved symbols that's a bug that should be reported, not ignored.

And changing runtime errors to build errors ensures that such errors 
never reach users (if the module is really unimportant disabling it 
is easy).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

