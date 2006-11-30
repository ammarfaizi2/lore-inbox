Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWK3P2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWK3P2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWK3P2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:28:53 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:38303 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S1030478AbWK3P2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:28:52 -0500
Date: Thu, 30 Nov 2006 10:28:51 -0500
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kswapd/tg3 issue
Message-ID: <20061130152851.GN2021@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20061130144355.GK2021@washoe.onerussian.com> <20061130150406.3d0b6afd@localhost.localdomain> <20061130151003.GM2021@washoe.onerussian.com> <1164899853.3233.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164899853.3233.19.camel@laptopd505.fenrus.org>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Arjan for advice

I had 5746, made it 8619.

Is that a good practice in general to have that value higher for a
server with lots of I/O including networking? (there is a RAID on that
system and 2 bonded gigabit interfaces) Is there any heuristic to decide
on that value ?

On Thu, 30 Nov 2006, Arjan van de Ven wrote:

> >...<

> actually since this was networking...
> you probably should bump the value in
> /proc/sys/vm/min_free_kbytes
> a bit (like by 50%); that makes the kernel keep a bigger pool free for
> emergencies/spikes...
> That might be enough already if your system isn't swapping a whole lot.
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Student  Ph.D. @ CS Dept. NJIT
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07102
WWW:     http://www.linkedin.com/in/yarik        
