Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWE2GWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWE2GWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWE2GWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:22:12 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44293 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751238AbWE2GWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:22:11 -0400
Date: Mon, 29 May 2006 08:09:12 +0200
From: Willy Tarreau <willy@w.ods.org>
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       bidulock@openss7.org, Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060529060912.GA30150@w.ods.org>
References: <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447A883C.5070604@opensound.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 10:35:56PM -0700, 4Front Technologies wrote:
> BTW, why is Mandriva the only distro to turn OFF REGPARM?. Again, I think 
> distros shouldn't be given an option to turn it off if its a good thing 
> to have.
> 
> Are there any good reasons why REGPARM is turned off?.
> 
> ------------------
> 
> 
> Yet one more reason to have something like kernel-config (similar to 
> gtk-config or xmms-config) where you can get the package's cflags, 
> ldflags, other info.
> 
> for example
> 
> kernel-config --cflags should say -DUSE_REGPARM -I/lib/modules/blah/blah
> 
> kernel-config --libdir should say where the lib/modules/blah/blah
> 
> kernel-config --srcdir should say where the kernel sources are installed 
> or not installed.
> 
> kernel-config --configsrc should configure the kernel source with the 
> running
> kernel's configuration.
> 
> kernel-config --installsrc should automatically download the RIGHT source 
> from the net. Right now if you go on Ubuntu or Mandrake and you try to 
> install kernel source - you get the option of stripped source, 
> kernel-headers, kernel-2.6.blah which may not be installed.
> 
> Any comments?

This is a wrong thing to do IMHO, because it is incompatible with
cross-compilation, and the more the projects will use this method,
the more a nightmare it will become for distro maintainers. At
least when you rely on either a config file or something like this,
it's always possible to make it point to your target system's. But
when you *execute* commands on the build system, chances are that
you will not get the expected result. pcre-config, glib-config and
such are already in this case.

> best regards
> Dev Mazumdar
> -----------------------------------------------------------
> 4Front Technologies
> 4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
> Tel: (310) 202 8530		URL: www.opensound.com
> Fax: (310) 202 0496 		Email: info@opensound.com
> -----------------------------------------------------------

Regards,
Willy

