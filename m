Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932990AbWFZT6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbWFZT6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932986AbWFZT6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:58:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932990AbWFZT6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:58:49 -0400
Subject: Re: [PATCH] IPMI: use schedule in kthread
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>,
       linux-kernel@vger.kernel.org, peter@palfrader.org,
       openipmi-developer@lists.sourceforge.net
In-Reply-To: <20060626194937.GA16528@lists.us.dell.com>
References: <20060626140819.GA17804@localdomain>
	 <20060626120048.cff87fac.akpm@osdl.org>
	 <20060626194937.GA16528@lists.us.dell.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 21:58:41 +0200
Message-Id: <1151351921.3185.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 14:49 -0500, Matt Domsch wrote:
> We need to be able to poll at faster-than-timer-tick rates, yet let
> other higher-priority apps run.  Hence the schedule().  We're open to
> other suggestions, but this seemed minimally intrusive while
> accomplishing the goal.  No more soft lockups or jittery mice.

at least put a whole bunch of cpu_relax() in that loop, or your cpu
will.. get hot. Would also be nice if cpufreq had a "run this one slow"
option.... 

