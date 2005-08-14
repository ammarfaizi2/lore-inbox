Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVHNTe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVHNTe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVHNTe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 15:34:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:5296 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751068AbVHNTe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 15:34:28 -0400
X-Authenticated: #20450766
Date: Sun, 14 Aug 2005 21:33:05 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.13
In-Reply-To: <1123184634.5026.58.camel@mulgrave>
Message-ID: <Pine.LNX.4.60.0508142121000.4594@poirot.grange>
References: <1123184634.5026.58.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.60.0508142124061.4594@poirot.grange>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 4 Aug 2005, James Bottomley wrote:

> This is my (hopefully final) collection of safe driver updates and bug
> fixes for 2.6.13.

Just to make sure everyone agrees on this - there's currently a know bug 
in dc395x with highmem reported by Pierre Ossman in thread "Kernel panic 
with dc395x in 2.6.12.2" on linux-scsi. It is also trivial to reproduce on 
non-highmem machines. It was there also in 2.6.12. It only was hit by one 
person because not many use dc395x controlled cards in highmem machines 
today. The fix is known - at least revert my patch to dc395x commited to 
2.6.12-rc5. This will fix this bug, leaving another one, which is much 
harder to hit. There was only one person who hit it, but he cannot test 
any more patches - the hardware is not there any more. I think I have a 
fix for that one too, but that's another story. So, I would say it would 
be worth it reverting that patch before 2.6.13, but, that's because I feel 
personal responsibility for that bug:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
