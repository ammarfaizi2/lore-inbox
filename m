Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVFNFvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFNFvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVFNFvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:51:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54225 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261232AbVFNFvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:51:43 -0400
Date: Tue, 14 Jun 2005 07:49:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] IDE CD more STANDARD_ATAPI ifdef
Message-ID: <20050614054947.GC1484@suse.de>
References: <42AE09FA.404@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AE09FA.404@tremplin-utc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14 2005, Eric Piel wrote:
> Hello,
> 
> This little patch adds more ifdef's to surround code not necessary for 
> the standard ATAPI drives. I've tried to find all the code that was 
> handling special cases. It reduces slightly more the module size :-) As 
> most of the non standard drives handled seem quite old, this is very safe.
> 
> This patch has to be applied after my previous patch 
> (ide-cd-2.6.12-report-current-speed.patch) but I can remake it directly 
> against latest vanilla kernel if you prefer. BTW, I'd like to make a 
> Kconfig option for STANDARD_ATAPI, would you accept it?

To be honest, I'd rather remove the STANDARD_ATAPI ifdef instead. It's
really not a lot of code, and the ifdefs are just cluttering it up. BTW,
if we were to honor STANDARD_ATAPI completely (ie strictly follow the
spec), there would be far more outside of such an ifdef. It's pretty
much an illusion and hasn't been followed for at least the last 5 years.

-- 
Jens Axboe

