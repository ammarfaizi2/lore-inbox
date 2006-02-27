Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWB0LYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWB0LYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWB0LYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:24:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750779AbWB0LYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:24:32 -0500
Subject: Re: [Lse-tech] Re: [Patch 4/7] Add sysctl for delay accounting
From: Arjan van de Ven <arjan@infradead.org>
To: balbir@in.ibm.com
Cc: dipankar@in.ibm.com, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20060227101124.GA22492@in.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028322.5785.60.camel@elinux04.optonline.net>
	 <1141028784.2992.58.camel@laptopd505.fenrus.org>
	 <4402BA93.5010302@watson.ibm.com>
	 <1141029743.2992.71.camel@laptopd505.fenrus.org>
	 <20060227090414.GA18941@in.ibm.com>
	 <1141031595.2992.76.camel@laptopd505.fenrus.org>
	 <20060227101124.GA22492@in.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 12:24:18 +0100
Message-Id: <1141039458.2992.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> One of the reasons that alloc_delays() is a bit ugly is to handle the case
> that tasks might get created between the two loops. Even with RCU kind of
> locking (except for changing the locking primitives of-course), this code would
> work fine. Once delayacct_on is set to 1, copy_process() should take care of
> allocating the delays structure. alloc_delays() re-iterates through the list
> of tasks to find tasks whose allocation got missed. This revisit happens
> at most once due to the small window in which we check for delayacct_on
> and allocate the task's delays structure. If tasks are missed within that
> window, we revisit the tasks again and allocate for them.

well you assume you CAN walk all tasks... which is something afaik
that's being deprecated ;)



