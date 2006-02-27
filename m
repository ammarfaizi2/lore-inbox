Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWB0Iae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWB0Iae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWB0Iae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:30:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14743 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932301AbWB0Iad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:30:33 -0500
Subject: Re: [Patch 6/7] Swapin page fault delays
From: Arjan van de Ven <arjan@infradead.org>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141028549.5785.67.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028549.5785.67.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:30:29 +0100
Message-Id: <1141029030.2992.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 03:22 -0500, Shailabh Nagar wrote:
> delayacct-swapin.patch
> 
> Record time spent by a task waiting for its pages to be swapped in.
> This statistic can help in adjusting the rss limits of 
> tasks (process), especially relative to each other, when the system is 
> under memory pressure.


ok this poses a question: how do you deal with nested timings? Say an
O_SYC write which internally causes a pagefault?
delayacct_timestamp_start() at minimum has to get event-type specific,
or even implement a stack of some sorts.

