Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbULZThx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbULZThx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 14:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbULZThx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 14:37:53 -0500
Received: from gprs213-131.eurotel.cz ([160.218.213.131]:14209 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261476AbULZThr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 14:37:47 -0500
Date: Sun, 26 Dec 2004 20:37:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wichert Akkerman <wichert@wiggy.net>
Subject: Re: Ho ho ho - Linux v2.6.10
Message-ID: <20041226193733.GB1739@elf.ucw.cz>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <1103977161.22646.6.camel@localhost.localdomain> <20041226113059.GC10303@wiggy.net> <200412261445.09336.Rafal.Wysocki@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412261445.09336.Rafal.Wysocki@fuw.edu.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.6.10 broke resume for me: when I resume it immediately tries to
> > suspend the machine again but gets stuck after suspending USB.
> 
> Usually, it resumes sucessfully for me, but sometimes it fails, like this (on 
> an AMD64):
> 
>  swsusp: Image: 43552 Pages
>  swsusp: Pagedir: 341 Pages
> pmdisk: Reading pagedir (341 Pages)
> Relocating 
> pagedir ...........................................................................................................................0
> 
> Call Trace:<ffffffff8016de7e>{__alloc_pages+766} 
> <ffffffff8016df21>{__get_free_pages+33}
>        <ffffffff8056191c>{swsusp_read+1020} 
> <ffffffff8015f711>{software_resume+33}
>        <ffffffff8010c142>{init+162} <ffffffff8010f57b>{child_rip+8}
>        <ffffffff8010c0a0>{init+0} <ffffffff8010f573>{child_rip+0}
> 
> out of memory
> ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::g
> PM: Resume from disk failed.

Hmm, this is probably "big order" allocation failing during
resume. hugang's patch could help here...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
