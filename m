Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759257AbWK3Q2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759257AbWK3Q2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759258AbWK3Q2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:28:10 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:35043 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S1759257AbWK3Q2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:28:07 -0500
Date: Thu, 30 Nov 2006 11:28:04 -0500
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Avi Kivity <avi@argo.co.il>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kswapd/tg3 issue
Message-ID: <20061130162804.GO2021@washoe.onerussian.com>
Mail-Followup-To: Avi Kivity <avi@argo.co.il>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20061130144355.GK2021@washoe.onerussian.com> <20061130150406.3d0b6afd@localhost.localdomain> <20061130151003.GM2021@washoe.onerussian.com> <20061130153906.59d78223@localhost.localdomain> <456EFC9F.9060607@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456EFC9F.9060607@argo.co.il>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On another box which has 4 times more RAM or a bit more than twice total
memory, it had twice as high vm.min_free_kbytes
on another node with even more RAM it is 13821..

hm - so what is the algorithm which sets it? percent of available RAM?

For now I am adjusting it on that server to be twice from default.

Thanks everyone for your help

On Thu, 30 Nov 2006, Avi Kivity wrote:

> Alan wrote:
> >Under heavy network or I/O pressure it may not have time to swap to get
> >the memory. Thus adding swap won't usually help. Adding RAM may do but
> >its often not the best answer. Arjan's suggestion should sort it, and -
> >yes typically boxes with very high I/O and network load need more of a
> >pool of memory free for immediate use than other systems.


> It could be nice if the kernel could autotune this, for example by raising the free memory goal when memory shortage is detected, and lowering it 
> gradually when not.

> The sysctl could be a minimum from which this is calculated.
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Student  Ph.D. @ CS Dept. NJIT
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07102
WWW:     http://www.linkedin.com/in/yarik        
