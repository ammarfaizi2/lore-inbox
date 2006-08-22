Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWHVOyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWHVOyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWHVOyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:54:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10147 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932268AbWHVOyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:54:54 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 16:54:10 +0200
User-Agent: KMail/1.9.3
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <200608221550.57603.ak@muc.de> <20060822142519.GX11651@stusta.de>
In-Reply-To: <20060822142519.GX11651@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221654.10558.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 16:25, Adrian Bunk wrote:
> On Tue, Aug 22, 2006 at 03:50:57PM +0200, Andi Kleen wrote:
> > 
> > > this would need a "const after boot" section; which is really not hard
> > > to make and probably useful for a lot more things.... todo++
> > 
> > except for anything that needs tlb entries in user space. And it only gives you
> > false sense of security. --todo
> 
> What's the alternative?

The alternative is to not protect it, since protecting it doesn't
offer any significant additional security over not protecting it.

> 
> Change it from a struct to a compile time choice?

One of the design goals of paravirt-ops was to allow single binaries
that run on both native hardware and on hypervisors. So that would
be a non starter.

-Andi

