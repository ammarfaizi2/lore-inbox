Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263607AbUEKUan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUEKUan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUEKUam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:30:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7906 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263607AbUEKUaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:30:35 -0400
Date: Tue, 11 May 2004 22:32:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, geoff@linux.jf.intel.com,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-ID: <20040511203236.GA6726@elte.hu>
References: <409FFF3B.3090506@linux.intel.com> <20040511004551.7c7af44d.akpm@osdl.org> <00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com> <20040511121126.73f5fdeb.akpm@osdl.org> <20040511195856.GA4958@elte.hu> <20040511131137.2390ffa8.akpm@osdl.org> <20040511211950.A20071@infradead.org> <20040511132619.7a4fb4cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511132619.7a4fb4cb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Nah, that's ungrammatical.  del_timer_singleshot means "delete a timer
> in a single-shot manner".
> 
> We have:
> 
> "add a timer"
> "modify a timer"
> "delete a timer"
> "delete a timer synchronously"
> "delete a single-shot timer"

hm, indeed. Miraculously, the existing timer API names are correct
grammatically, so we might as well go for del_single_shot_timer() ...

	Ingo
