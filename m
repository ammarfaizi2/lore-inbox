Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286250AbRLTNeo>; Thu, 20 Dec 2001 08:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286251AbRLTNee>; Thu, 20 Dec 2001 08:34:34 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:19917
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S286250AbRLTNeS>; Thu, 20 Dec 2001 08:34:18 -0500
Date: Thu, 20 Dec 2001 08:29:26 -0500
From: Chris Mason <mason@suse.de>
To: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>
cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.14 and 2.4.16
Message-ID: <1266972704.1008854966@tiny>
In-Reply-To: <3C1A4BB4.EA8C4B45@zip.com.au>
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE>
 <000a01c1829f$75daf7a0$050010ac@FUTURE> <3825380000.1008348567@tiny>
 <3C1A3652.52B989E4@zip.com.au>
 <3845670000.1008352380@tiny>,	<3845670000.1008352380@tiny>; from
 mason@suse.com on Fri, Dec 14, 2001 at 12:53:00PM -0500
 <20011214193217.H2431@athlon.random> <3C1A4BB4.EA8C4B45@zip.com.au>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there is another deadlock possible where kswapd goes into a transaction:

shrink_dcache_memory->prune_dcache->dput->iput->delete_inode()

So, I'm changing my new kinoded to run shrink_dcache_memory as well.

ick.

-chris

