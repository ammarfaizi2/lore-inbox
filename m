Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVIDO3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVIDO3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 10:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVIDO3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 10:29:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45802 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750821AbVIDO3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 10:29:34 -0400
Date: Sun, 4 Sep 2005 16:29:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-mm1: PCMCIA problem
Message-ID: <20050904142907.GC1827@elf.ucw.cz>
References: <20050901035542.1c621af6.akpm@osdl.org> <20050901142813.47b349ed.akpm@osdl.org> <200509021030.06874.rjw@sisk.pl> <200509021037.16536.rjw@sisk.pl> <20050902104319.GB9647@elf.ucw.cz> <20050902040926.6e02c4e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902040926.6e02c4e8.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > One more piece of information.  This is the one that loops:
> >  > 
> >  > echo 30 > /sys/class/firmware/timeout
> > 
> >  Try echo -n ...
> 
> Or revert gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch. 
> Obviously if you write 30\n and the write returns 2 then the shell will
> then try to write the \n.  That returns zero and the shell tries again, ad
> infinitum.

Can you revert
gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch, instead?

Kernel should not provide "nice" interface. Striping trailing
whitespace is wrong, just teach users to use sysfs right.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
