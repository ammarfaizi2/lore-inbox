Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbTJ0STj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTJ0STj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:19:39 -0500
Received: from havoc.gtf.org ([63.247.75.124]:3513 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263454AbTJ0STG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:19:06 -0500
Date: Mon, 27 Oct 2003 13:17:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Bob Johnson <livewire@gentoo.org>
Cc: Shaun Savage <savages@savages.net>, linux-kernel@vger.kernel.org,
       edt@aei.ca, nuno.silva@vgertech.com
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
Message-ID: <20031027181738.GB5335@gtf.org>
References: <3F9D402F.9050509@savages.net> <200310271308.53135.livewire@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310271308.53135.livewire@gentoo.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 01:08:46PM -0500, Bob Johnson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The Sata driver worked well on my siimage, but lost around 30%-40% performance
> according to tiobench.

This is to be expected -- I use a "sledgehammer fix" for the Maxtor and
Seagate errata -- each transfer is limited to 15 sectors.

When I get a chance to clean up the SiI driver, the performance will
indeed increase by a large amount.

For now, for Silicon Image, I recommend using the
drivers/ide/pci/siimage.c -- assuming it works for you, of course.

The libata Silicon Image driver is marked with CONFIG_BROKEN because it
is fairly easy to lock it up (I need ack some more interrupts).

	Jeff



