Return-Path: <linux-kernel-owner+w=401wt.eu-S965301AbXAHJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbXAHJrm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbXAHJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:47:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37803 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965301AbXAHJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:47:37 -0500
Date: Mon, 8 Jan 2007 10:43:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070108094359.GB30482@elte.hu>
References: <20070105215223.GA5361@elte.hu> <45A0E586.50806@qumranet.com> <20070107174416.GA14607@elte.hu> <45A1FF4E.1020106@qumranet.com> <20070108083935.GB18259@elte.hu> <45A20A0A.70403@qumranet.com> <20070108091819.GB26587@elte.hu> <45A20F60.20207@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A20F60.20207@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> Looks like a lot of complexity for very little gain.  I'm not sure 
> what the vmwrite cost is, cut it can't be that high compared to 
> vmexit.

while i disagree with characterising one extra parameter passed down 
plus one extra branch as 'a lot of complexity', i agree that making the 
flush a NOP on VMX is even better. (if it's possible without breaking 
future hardware) I guess you are right that the only true cost here is 
the vmwrite cost, and that there's no impact on CR3 flushing (because it 
happens unconditionally). Forget about this patch.

	Ingo
