Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVA2Shi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVA2Shi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVA2Shi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:37:38 -0500
Received: from colin2.muc.de ([193.149.48.15]:62980 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261399AbVA2Shc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:37:32 -0500
Date: 29 Jan 2005 19:37:31 +0100
Date: Sat, 29 Jan 2005 19:37:31 +0100
From: Andi Kleen <ak@muc.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5 and ATA disk failure/recovery modes
Message-ID: <20050129183731.GA40659@muc.de>
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de> <20050127063131.GA29574@schmorp.de> <20050127095102.GA88779@muc.de> <20050127163323.GA7474@schmorp.de> <20050129183511.GA2055@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129183511.GA2055@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, you could set stripe size to 512B; that way, RAID-5 would be
> *very* slow, but it should have same characteristics as normal disc
> w.r.t. crash. Unrelated data would not be lost, and you'd either get
> old data or new data...

When you lose a disk during recovery you can still lose
unrelated data (any "sibling" in a stripe set because its parity
information is incomplete).  RAID-1 doesn't have this problem though.

-Andi
