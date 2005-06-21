Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFUIR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFUIR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVFUIRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:17:38 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:30857 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261163AbVFUHgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:36:13 -0400
Date: Tue, 21 Jun 2005 09:36:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: domen@coderock.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
Message-ID: <20050621073615.GF27887@wohnheim.fh-wedel.de>
References: <20050620215712.840835000@nd47.coderock.org> <20050620221041.GI2222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050620221041.GI2222@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 June 2005 00:10:41 +0200, Pavel Machek wrote:
> 
> > The attached patch:
> > 
> > o  Fixes kernel/power/disk.c string declared as 'char *p = "...";' to be
> >    declared as 'char p[] = "...";', as pointed by Jeff Garzik.
> 
> ? Why was char *p ... wrong? Because you could not do sizeof() later?

Not necessarily wrong, but iirc, "*p" can waste 4 bytes (or 8, for
64-bit platforms).  Since this variable isn't static, that's a
non-issue, but I've seen it on some kernel-janitor list anyway.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
