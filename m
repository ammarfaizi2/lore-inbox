Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUH2MHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUH2MHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUH2MHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:07:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43222 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267681AbUH2MHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:07:02 -0400
Date: Sun, 29 Aug 2004 14:03:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040829120324.GB10112@suse.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151837.GD12772@fs.tum.de> <200408281932.05964.vda@port.imtp.ilyichevsk.odessa.ua> <20040828205823.GB8716@suse.de> <20040828212419.GM12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828212419.GM12772@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28 2004, Adrian Bunk wrote:
> On Sat, Aug 28, 2004 at 10:58:23PM +0200, Jens Axboe wrote:
> > 
> > BUG_ON(1); must always BUG(). That said, it's never wise to put
> > expressions with side-effects into macros.
> 
> The intention is, to add an option that lets BUG/BUG_ON/WARN_ON/PAGE_BUG 
> do nothing. This option should be hidden under EMBEDDED.
> 
> In some environments, this seems to be desirable.

That only makes sense if you are using BUG incorrectly. A BUG()
condition is something that is non-recoverable, undefining that doesn't
make any sense regardless of the environment.

-- 
Jens Axboe

