Return-Path: <linux-kernel-owner+w=401wt.eu-S1750887AbXACP7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXACP7X (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbXACP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:59:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37546 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbXACP7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:59:22 -0500
Date: Wed, 3 Jan 2007 16:56:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 2.6.19.1-rt15][RFC] - futex_requeue_pi implementation (requeue from futex1 to PI-futex2)
Message-ID: <20070103155609.GB11066@elte.hu>
References: <459BA267.1020706@bull.net> <20070103123536.GA9088@elte.hu> <459BBF15.5070505@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459BBF15.5070505@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> Ingo Molnar a écrit :
> >
> >looks good to me in principle. The size of the patch is scary - is there 
> >really no simpler way? 
> 
> Humf, in fact, for the 64-bit part, I've followed the rule of the 
> existing 64-bit code in futex.c, which consists of duplicating all the 
> functions which can not be kept common, and add a suffix 64 to all 
> duplicated functions. Perhaps I missed something ?

i dont think you missed anything - but some consolidation here would be 
nice. Only if possible of course :-)

	Ingo
