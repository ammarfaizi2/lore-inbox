Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUAUSAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUAUSAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:00:34 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:14003 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263953AbUAUSAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:00:33 -0500
Subject: Re: [Dri-devel] [2.6 patch] disallow DRM on 386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040121002827.GG6441@fs.tum.de>
References: <20040120212421.GF12027@fs.tum.de>
	 <1074643498.25861.14.camel@dhcp23.swansea.linux.org.uk>
	 <20040121002827.GG6441@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074707769.25859.37.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Jan 2004 17:56:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-01-21 at 00:28, Adrian Bunk wrote:
> > Fix system.h to always define cmpxchg.h and check its presence at
> > runtime when the DRM module loads, then you can build 386 kernels that
> > support DRI on higher machines.
> > 
> > The problem isnt that cmpxchg definitely doesn't exist, so system.h is
> > wrong IMHO
> 
> ???
> 
> AFAIR cmpxchg wasn't present in cpus earlier than the 486.

This is not relevant to the discussion assuming you are talking about
kernels for 386 and higher as well as kernels solely for Intel 386. If
the kernel is for 386 and higher then the DRI modules should be built
but should check for cmpxchg at run time - as we do with many other
CPU features


