Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVGEOBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVGEOBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGEN6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:58:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22489 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261845AbVGENxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:53:21 -0400
Date: Tue, 5 Jul 2005 15:53:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT 50-51 : cannot compile on i386
Message-ID: <20050705135318.GB13614@elte.hu>
References: <1120567250.6225.24.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120567250.6225.24.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Hi,
> 
> I have another compile problem :
> 
>   CC      arch/i386/kernel/apm.o
> arch/i386/kernel/apm.c:424: error: syntax error before ',' token
> arch/i386/kernel/apm.c:425: error: syntax error before ',' token
> arch/i386/kernel/apm.c:427: error: syntax error before ',' token

i have fixed these build errors in -51-00.

-51-00 also has new debugging code which could help with your original 
network-driver problem: assymetric spin locking and spin unlocking is 
being detected and reported automatically. (if CONFIG_DEBUG_PREEMPT is 
enabled)

	Ingo
