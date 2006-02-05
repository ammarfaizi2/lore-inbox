Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWBECAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWBECAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 21:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWBECAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 21:00:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14304 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030253AbWBECAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 21:00:48 -0500
Date: Sat, 4 Feb 2006 18:00:26 -0800
From: Paul Jackson <pj@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: christoph@lameter.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       manfred@colorfullife.com
Subject: Re: [RFT/PATCH] slab: consolidate allocation paths
Message-Id: <20060204180026.b68e9476.pj@sgi.com>
In-Reply-To: <1139070779.21489.5.camel@localhost>
References: <1139060024.8707.5.camel@localhost>
	<Pine.LNX.4.62.0602040709210.31909@graphe.net>
	<1139070369.21489.3.camel@localhost>
	<1139070779.21489.5.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This consolidation patch looks ok to me on first read, though others
are certainly more expert in this code than I am.  Certainly cleanup,
ifdef reduction and consolidation of mm/slab.c is a worthwhile goal.
That code is rough for folks like me to follow.

Two issues I can see:

  1) This patch increased the text size of mm/slab.o by 776
     bytes (ia64 sn2_defconfig gcc 3.3.3), which should be
     justified.  My naive expectation would have been that
     such a source code consolidation patch would be text
     size neutral, or close to it.

  2) You might want to hold off this patch for a few days,
     until the dust settles from my memory spread patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
