Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUH2OPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUH2OPY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUH2OPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:15:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267839AbUH2OPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:15:22 -0400
Date: Sun, 29 Aug 2004 16:08:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Oliver Neukum <oliver@neukum.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040829140827.GB10955@suse.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828212419.GM12772@fs.tum.de> <20040829120324.GB10112@suse.de> <200408291418.50255.oliver@neukum.org> <20040829130155.GA10279@suse.de> <20040829135037.GA12134@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829135037.GA12134@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29 2004, Adrian Bunk wrote:
> On Sun, Aug 29, 2004 at 03:01:56PM +0200, Jens Axboe wrote:
> > On Sun, Aug 29 2004, Oliver Neukum wrote:
> > > Am Sonntag, 29. August 2004 14:03 schrieb Jens Axboe:
> > > > > The intention is, to add an option that lets BUG/BUG_ON/WARN_ON/PAGE_BUG 
> > > > > do nothing. This option should be hidden under EMBEDDED.
> > > > > 
> > > > > In some environments, this seems to be desirable.
> > > > 
> > > > That only makes sense if you are using BUG incorrectly. A BUG()
> > > > condition is something that is non-recoverable, undefining that doesn't
> > > > make any sense regardless of the environment.
> > > 
> > > Why not? Giving reports about unrecoverable errors is sensible
> > > only if the report can be read. On system this is not the case, you
> > > can just salvage the memory and let it crash.
> > 
> > "Unrecoverable" can quite easily mean "something really bad has
> > happened, corruption imminent". So maybe you would want BUG/BUG_ON to
> > restart the box there, the restart-on-panic should help you there.
> >...
> 
> The current sh/sh64 implementation doesn't seem to do any of the things 
> you expect from BUG:
> 
> #define BUG() do { \
>         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
>         asm volatile("nop"); \
> } while (0)

Well too bad for them, I'm glad I'm not trusting any data to a machine
with that architecture.

-- 
Jens Axboe

