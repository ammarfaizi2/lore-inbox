Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbUK3QmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbUK3QmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUK3QmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:42:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262173AbUK3QlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:41:18 -0500
Date: Tue, 30 Nov 2004 11:40:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Gerrit Huizenga <gh@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [PATCH] CKRM: 8/10 CKRM:  Resource controller for
 prioritizing inbound network requests
In-Reply-To: <E1CYqcL-0005A1-00@w-gerrit.beaverton.ibm.com>
Message-ID: <Xine.LNX.4.44.0411301137510.12330-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004, Gerrit Huizenga wrote:

> +#ifdef CONFIG_ACCEPT_QUEUES
> +	tp->class_index = 0;
> +	for (i=0; i < NUM_ACCEPT_QUEUES; i++) {
> +		tp->acceptq[i].aq_tail = NULL;
> +		tp->acceptq[i].aq_head = NULL;
> +		tp->acceptq[i].aq_wait_time = 0; 
> +		tp->acceptq[i].aq_qcount = 0; 
> +		tp->acceptq[i].aq_count = 0; 
> +		if (i == 0) {
> +			tp->acceptq[i].aq_ratio = 1; 
> +		}
> +		else {
> +			tp->acceptq[i].aq_ratio = 0; 
> +		}
> +	}
> +#endif

Do not litter the networking code with #ifdef sections.  Use functions
which are defined to nothing via static inline if disabled.


- James
-- 
James Morris
<jmorris@redhat.com>


