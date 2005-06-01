Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVFAJYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFAJYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFAJYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:24:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30416 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261350AbVFAJYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:24:46 -0400
Date: Wed, 1 Jun 2005 11:21:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050601092102.GB13041@elte.hu>
References: <Pine.LNX.4.44.0505230800580.863-100000@dhcp153.mvista.com> <42920958.B67C742F@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42920958.B67C742F@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Another problem in plist_add:
> 
> > existing_sp_head:
> > 	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> > 	list_add(&pl->sp_node, &itr_pl2->sp_node);
> 
> This breaks fifo ordering.

Daniel, is the issue (and other issues) Oleg noticed still present? I'm 
still a bit uneasy about the complexity of the plist changes.

	Ingo
