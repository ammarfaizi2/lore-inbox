Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWCUPNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWCUPNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWCUPNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:13:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6415 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751751AbWCUPNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:13:11 -0500
Date: Sun, 19 Mar 2006 16:32:50 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: Phillip Lougher <phillip@lougher.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060319163249.GA3856@ucw.cz>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441AF118.7000902@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-03-06 12:25:44, Jeff Garzik wrote:
> Phillip Lougher wrote:
> >On 17 Mar 2006, at 16:00, Jeff Garzik wrote:
> >>Jörn Engel wrote:
> >>>>>The one still painfully missing is a
> >>>>>fixed-endianness disk format.
> 
> >>Fixed endian isn't necessarily a requirement.  
> >>Detectable endian  is.  As long as (a) the filesystem 
> >>mkfs notes the endian-ness and  (b) the kernel 
> >>filesystem code properly handles both types of  endian, 
> >>life is fine.
> >>
> >That's what is currently done.  There are two filesystem 
> >formats, big  endian (donated by Squashfs magic of 
> >'sqsh') and little endian  (denoted by Squashfs magic of 
> >'hsqs').  The kernel code detects the  filesystem 
> >endianness and swaps if necessary.
> 
> Well, then, I don't see a need to change anything.  As I 
> said, [consistent and] detectable endian is the real 
> requirement.  For SquashFS's users, I would think they 
> would prefer the current situation (selectable endian) to 
> fixed endian, because many SquashFS users need to squeeze 
> every ounce of performance out of severely 
> resource-constrained devices.
> 
> I have two routers, ADM5120-based Edimax and LinkSys 
> WRT54G v5, both of which have a mere 2MB of flash, and 
> both use SquashFS to maximize that space.  And both are 
> el cheapo, slow embedded processors that run far slower 
> than 300Mhz.  I look askance at anyone who wants to make 
> an arbitrary filesystem design decision imposing tons of 
> bytesex upon these lowly devices.

gzip is already pretty expensive, I'd say. Is not byteswap lost in
noise?

-- 
Thanks, Sharp!
