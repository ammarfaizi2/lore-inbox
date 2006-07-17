Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWGQPBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWGQPBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWGQPBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:01:09 -0400
Received: from mail.gmx.net ([213.165.64.21]:56003 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750821AbWGQPBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:01:07 -0400
X-Authenticated: #428038
Date: Mon, 17 Jul 2006 17:01:05 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060717150105.GB8276@merlin.emma.line.org>
Mail-Followup-To: Christian Trefzer <ctrefzer@gmx.de>,
	Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716162831.GB22562@zeus.uziel.local>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer schrieb am 2006-07-16:

> fsck on a faulty drive might cause even more damage - how do you know
> that other areas of the device are OK? 

All drives I bought in the recent years shipped with ARRE and ARWE set.
Any halfway decent fsck tool can just rewrite the b0rked sector and the
drive transparently remaps a spare.

If reiser4 crashes the kernel instead, it's not failure resilient and is
certainly not ready for production.

> I also oppose the ReiserFS-v3.x design philosophy regarding faulty
> storage layer, but in any case where your _live_ data is valuable and
> uptime counts, you _really_should_ use a RAID of some sort.

...and certainly a backup system that gives you FAST access to the data.
RAID doesn't protect against accidents with rm(1) or, worse, wipe(1).

-- 
Matthias Andree
