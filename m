Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVCWXbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVCWXbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVCWXbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:31:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63383 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262098AbVCWXbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:31:02 -0500
Date: Wed, 23 Mar 2005 15:30:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>
cc: cmm@us.ibm.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-ID: <25760000.1111620606@flay>
In-Reply-To: <20050323232656.GA5704@pclin040.win.tue.nl>
References: <20050315204413.GF20253@csail.mit.edu> <20050316003134.GY7699@opteron.random> <20050316040435.39533675.akpm@osdl.org> <20050316183701.GB21597@opteron.random> <1111607584.5786.55.camel@localhost.localdomain> <20050323144953.288a5baf.akpm@osdl.org> <17250000.1111619602@flay> <20050323152055.6fc8c198.akpm@osdl.org> <20050323232656.GA5704@pclin040.win.tue.nl>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nothing beats poking around in a dead machine's guts with kgdb though.
> 
> Everyone his taste.
> 
> But I was surprised by
> 
>> SwapTotal:     1052216 kB
>> SwapFree:      1045984 kB
> 
> Strange that processes are killed while lots of swap is available.

I don't think we're that smart about it. If we're really low on mem, it
seems we invoke the OOM killer whether processes are causing the problem
or not. 

OTOH, if we can't free the kernel mem, we don't have much choice, but 
it's not really helping much ;-)

M.

