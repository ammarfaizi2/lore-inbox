Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVAGLoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVAGLoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVAGLoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:44:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63973 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261347AbVAGLoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:44:13 -0500
Date: Fri, 7 Jan 2005 12:43:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, rusty@rustcorp.com.au,
       paulus@au1.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] mm_struct leak on cpu hotplug (s390/ppc64)
Message-ID: <20050107114353.GA29779@elte.hu>
References: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com> <1104892877.8954.27.camel@localhost.localdomain> <20050105110833.GA14956@elte.hu> <1104939854.18695.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104939854.18695.29.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Lynch <nathanl@austin.ibm.com> wrote:

> OK, how's this?  I'll submit the sched and ppc64 bits separately if
> there are no objections.  I assume Heiko can take care of s390.
> 
> Note that in the ppc64 cpu_die function we must call idle_task_exit
> before calling ppc_md.cpu_die, because the latter does not return.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
