Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWA1VfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWA1VfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWA1VfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:35:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750737AbWA1VfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:35:23 -0500
Date: Sat, 28 Jan 2006 22:29:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Chase Venters <chase.venters@clientec.com>
Cc: Nix <nix@esperi.org.uk>, Ariel <askernel2615@dsgml.com>,
       Jamie Heilman <jamie@audible.transient.net>,
       Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Message-ID: <20060128212911.GC13084@suse.de>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <87ek2td4i9.fsf@amaterasu.srvr.nix> <20060128192714.GI9750@suse.de> <200601281347.10531.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601281347.10531.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28 2006, Chase Venters wrote:
> On Saturday 28 January 2006 13:26, Jens Axboe wrote:
> > It's not a bad data point, it just confirms that setting ->ordered_flush
> > to 0 in the SATA drivers will fix the leak. So really, it's as expected.
> > So far apparently nobody tried it, suggested it twice.
> 
> In case you still wanted the data point, I just set ordered_flush to 0 on my 
> ata_piix and the slab leak disappeared.

Thanks for confirming!

-- 
Jens Axboe

