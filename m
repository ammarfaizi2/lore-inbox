Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTEYQ5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 12:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTEYQ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 12:57:36 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:40833 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263547AbTEYQ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 12:57:35 -0400
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
	2.5.30(at least))
From: David Woodhouse <dwmw2@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Lothar Wassmann <LW@KARO-electronics.de>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305231640150.1570-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0305231640150.1570-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1053882629.17182.8.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sun, 25 May 2003 18:10:29 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: hugh@veritas.com, LW@KARO-electronics.de, rmk@arm.linux.org.uk, akpm@digeo.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-23 at 16:42, Hugh Dickins wrote:
> On Fri, 23 May 2003, Lothar Wassmann wrote:
> > I'm using a custom PXA250/255 board (same problem on both processors)
> > with either kernel 2.5.30-rmk1-pxa1 or 2.5.68-rmk1-pxa1. Both show the
> > same malfunction when reading a file non-sequentially from an IDE CF
> > card.
> 
> Which filesystem - jffs2 or some other?

Presumably the latter. JFFS2 works on flash, not on IDE -- unless you
load the 'blkmtd' driver which uses a block device as backing store for
a 'virtual' MTD device.

-- 
dwmw2


