Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVKAVJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVKAVJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKAVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:09:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35778 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751195AbVKAVJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:09:49 -0500
Date: Tue, 1 Nov 2005 22:09:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] swsusp: reduce code duplication (was: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c)
Message-ID: <20051101210911.GI7172@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <20051031220233.GC14877@elf.ucw.cz> <200511011357.16995.rjw@sisk.pl> <200511011833.19585.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011833.19585.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Speaking of simplifications and having seen your code I hope you will agree with
> > > > the appended patch against vanilla 2.6.14-git3 (it reduces the duplication of code,
> > > > and replaces swsusp_pagedir_relocate with a simpler mechanism).
> > > 
> > > ...and also moves stuff around in a way
> > > 
> > > a) I don't like
> > > 
> > > and
> > > 
> > > b) is almost impossible to review
> > 
> > OK, I'll try to split it into two patches to make it cleaner.
> 
> The first patch is appended, the next one will be in the reply to this message.
> 
> The changes made by the appended patch are necessary for the relocation
> simplification in the next patch.  Still, the changes allow us to drop
> check_pagedir() and make get_safe_page() be a one-line wrapper around
> alloc_image_page() (get_safe_page() goes to snapshot.c, because
> alloc_image_page() is static and it does not make sense to export
> it).

ACK.
								Pavel
-- 
Thanks, Sharp!
