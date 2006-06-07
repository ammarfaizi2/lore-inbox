Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWFGRmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWFGRmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWFGRmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:42:00 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:61970 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932368AbWFGRl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:41:59 -0400
Message-ID: <44870FD6.1040405@shadowen.org>
Date: Wed, 07 Jun 2006 18:41:42 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
References: <4484D174.7080902@google.com>
In-Reply-To: <4484D174.7080902@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> http://test.kernel.org/abat/34264/debug/console.log
> 
> Only seems to happen on the sparsemem runs. Possibly a side-effect
> of the page migration stuff, manifesting itself differently?
> Or maybe not?
> 

Ok, this shouldn't be that issue as the sparsemem checks won't tickle
that puppy, not enough swap devices in use.  That said, I've just run a
full sweep of sparsemem and its GOOD across the board on swap patch and
2222 deadlock.  Sadly this failure is on a machine which has just bitten
the dust and I'm waiting for it to be mended.  Not sure how long that
will take.

-apw
