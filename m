Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWGGKjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWGGKjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWGGKjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:39:41 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:47829 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932112AbWGGKjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:39:40 -0400
Date: Fri, 7 Jul 2006 12:39:21 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060707123921.6e35284e@cad-250-152.norway.atmel.com>
In-Reply-To: <1152187083.2987.117.camel@pmac.infradead.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<1152187083.2987.117.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 12:58:03 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> Please add include/asm-avr32/Kbuild which lists those files which need
> to be present in /usr/include/asm, over and above those listed in
> asm-generic/Kbuild.asm. Then run 'make headers_install' and review the
> exported headers to make sure they're suitable for building glibc,
> etc.

uClibc fails because it tries to grep for UTS_RELEASE in
linux/version.h and doesn't find it because it's been moved to
linux/utsrelease.h. I can update the script so that it checks
linux/utsrelease.h first, but that file is not installed by
make headers_install.

Should utsrelease.h be added to objhdr-y or should uClibc handle this
some other way?

Håvard
