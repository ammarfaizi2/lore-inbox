Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUCIPGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCIPGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:06:35 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:52723 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261906AbUCIPGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:06:34 -0500
Date: Tue, 9 Mar 2004 08:06:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040309150632.GH15065@smtp.west.cox.net>
References: <200403081504.30840.amitkale@emsyssoft.com> <20040308022602.766be828.akpm@osdl.org> <200403081619.16771.amitkale@emsyssoft.com> <200403091459.54161.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403091459.54161.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 02:59:54PM +0530, Amit S. Kale wrote:
[snip]
> I attempted it and found that it works better than my expectation! I am 
> attaching revised core-lite.patch with this email and sending i386-lite.patch 
> as a reply.
[snip]
> Index: linux-2.6.4-rc2-bk3-kgdb/include/linux/kgdb.h
[snip]
> +#ifndef KGDB_MAX_NO_CPUS
> +#if CONFIG_NR_CPUS > 8
> +#error KGDB can handle max 8 CPUs
> +#endif
> +#define KGDB_MAX_NO_CPUS 8
> +#endif

We need to remove all of that in favor of s/KGDB_MAX_NO_CPUS/NR_CPUS/g,
and remove the check on 8.

-- 
Tom Rini
http://gate.crashing.org/~trini/
