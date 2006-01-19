Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWASWNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWASWNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWASWNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:13:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43953 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422661AbWASWNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:13:04 -0500
Subject: Re: [PATCH] powerpc: remove useless spinlock from mpc83xx watchdog
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kumar Gala <galak@gate.crashing.org>, Andrew Morton <akpm@osdl.org>,
       wim@iguana.be, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
In-Reply-To: <20060119164811.GB4418@dmt.cnet>
References: <Pine.LNX.4.44.0601190057130.8484-100000@gate.crashing.org>
	 <1137664156.8471.16.camel@localhost.localdomain>
	 <20060119164811.GB4418@dmt.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 22:12:19 +0000
Message-Id: <1137708739.8471.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 14:48 -0200, Marcelo Tosatti wrote:
> On Thu, Jan 19, 2006 at 09:49:16AM +0000, Alan Cox wrote:
> > 
> > 	f = open("/dev/watchdog", O_RDWR);
> > 	fork();
> > 	while(1) {
> > 		write(f, "Boing", 5);
> > 	}
> 
> Oops.
> 
> At least 50% of the watchdog drivers rely solely on the "wdt_is_open"
> atomic variable and are broken with respect to synchronization.

What an excellent janitors project

