Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUH2NCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUH2NCi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUH2NCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:02:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6886 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267798AbUH2NC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:02:28 -0400
Date: Sun, 29 Aug 2004 15:01:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040829130155.GA10279@suse.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828212419.GM12772@fs.tum.de> <20040829120324.GB10112@suse.de> <200408291418.50255.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408291418.50255.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29 2004, Oliver Neukum wrote:
> Am Sonntag, 29. August 2004 14:03 schrieb Jens Axboe:
> > > The intention is, to add an option that lets BUG/BUG_ON/WARN_ON/PAGE_BUG 
> > > do nothing. This option should be hidden under EMBEDDED.
> > > 
> > > In some environments, this seems to be desirable.
> > 
> > That only makes sense if you are using BUG incorrectly. A BUG()
> > condition is something that is non-recoverable, undefining that doesn't
> > make any sense regardless of the environment.
> 
> Why not? Giving reports about unrecoverable errors is sensible
> only if the report can be read. On system this is not the case, you
> can just salvage the memory and let it crash.

"Unrecoverable" can quite easily mean "something really bad has
happened, corruption imminent". So maybe you would want BUG/BUG_ON to
restart the box there, the restart-on-panic should help you there.

You're mail is not making a case for defining BUG/BUG_ON to a nop, which
is what the discussion is about.

-- 
Jens Axboe

