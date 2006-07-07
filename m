Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWGGKo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWGGKo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWGGKo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:44:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3549 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751004AbWGGKoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:44:25 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: Arjan van de Ven <arjan@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060707123921.6e35284e@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <1152187083.2987.117.camel@pmac.infradead.org>
	 <20060707123921.6e35284e@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 12:44:22 +0200
Message-Id: <1152269062.3111.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 12:39 +0200, Haavard Skinnemoen wrote:
> On Thu, 06 Jul 2006 12:58:03 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > Please add include/asm-avr32/Kbuild which lists those files which need
> > to be present in /usr/include/asm, over and above those listed in
> > asm-generic/Kbuild.asm. Then run 'make headers_install' and review the
> > exported headers to make sure they're suitable for building glibc,
> > etc.
> 
> uClibc fails because it tries to grep for UTS_RELEASE in
> linux/version.h and doesn't find it because it's been moved to
> linux/utsrelease.h. I can update the script so that it checks
> linux/utsrelease.h first, but that file is not installed by
> make headers_install.

I would say that version.h should most certainly not be exposed to
userspace. utsrelease.h.. since it's exposing a string... MAYBE. But
really.. how can userspace use this at all in any useful way?

Greetings,
    Arjan van de Ven

