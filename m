Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVILTot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVILTot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVILTor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:44:47 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:12763
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1751130AbVILTop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:44:45 -0400
Date: Mon, 12 Sep 2005 15:40:32 -0400
From: Sonny Rao <sonny@burdell.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.13-mm3
Message-ID: <20050912194032.GA12426@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org
References: <20050912024350.60e89eb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912024350.60e89eb1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting some build errors on ppc64 in drivers/char/hvc_console.c


  CC      drivers/char/hvc_console.o
drivers/char/hvc_console.c: In function `hvc_poll':
drivers/char/hvc_console.c:600: error: `count' undeclared (first use in this function)
drivers/char/hvc_console.c:600: error: (Each undeclared identifier is reported only once
drivers/char/hvc_console.c:600: error: for each function it appears in.)
drivers/char/hvc_console.c:636: error: structure has no member named `flip'
make[1]: *** [drivers/char/hvc_console.o] Error 1
make: *** [_module_drivers/char] Error 2

The count undeclared one was easy to fix but I coldn't fix the filp
structure element in 2-3 minutes so I'm punting.

Anyone have a patch to fix this driver?

Sonny
