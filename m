Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVBKSty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVBKSty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVBKSty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:49:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262286AbVBKSs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:48:26 -0500
Date: Fri, 11 Feb 2005 13:48:21 -0500
From: Dave Jones <davej@redhat.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, tripperda@nvidia.com
Subject: Re: How to disable slow agpgart in kernel config?
Message-ID: <20050211184821.GC15721@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
	tripperda@nvidia.com
References: <200502111804.06899.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502111804.06899.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 06:04:06PM +0000, Nick Warne wrote:

 > > > This surprises me, especially considering the in-kernel nvidia-agp driver
 > > > was actually written by NVidia. Are there any agp error messages in
 > > > your dmesg / X log ?
 > 
 > > With the nVidia own nv_agp it appears directly in all apps, very fast 
 > > under GNOME 2.8.1. Why, I do not know. Also game (opengl) performance is 
 > > faster with the nv_agp, that I haven't used the kernel agp for months, now.
 > 
 > This is interesting.  I always used agpgart without a second thought (2.4.29, 
 > GeForce4 MX with Via KT133 chipset).
 > 
 > I just read through the nVidia readme file, and there is a comprehensive 
 > section on what module to use for what chipset (and card).  It recommends 
 > using the nVagp for my setup, so I just rebuilt excluding agpgart so I can 
 > use the nVdia module.
 > 
 > I never had slowness as such in KDE or X apps, but playing quake2 openGL I 
 > used to get a 'wave' type effect rippling down the screen occasionally.  A 
 > quick test using the nVagp module to have fixed that...

Terrence, any ideas ?

The only thing that jumps to mind that the nvidia gart driver is doing
that the opensource one isn't is fiddling with PAT bits in the GART
pages, but if anything, that should be just a performance thing.

(It'd be really nice to get your PAT support in 2.6 sometime too btw).

		Dave

