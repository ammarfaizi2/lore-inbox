Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUHPLDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUHPLDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHPLDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:03:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:57325 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267528AbUHPLDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:03:22 -0400
X-Authenticated: #4399952
Date: Mon, 16 Aug 2004 13:13:59 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
Message-Id: <20040816131359.1107bd69@mango.fruits.de>
In-Reply-To: <20040816040515.GA13665@elte.hu>
References: <20040815115649.GA26259@elte.hu>
	<20040816022554.16c3c84a@mango.fruits.de>
	<1092622121.867.109.camel@krustophenia.net>
	<20040816023655.GA8746@elte.hu>
	<1092624221.867.118.camel@krustophenia.net>
	<20040816032806.GA11750@elte.hu>
	<20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 06:05:15 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Anyway, the change to sched.c fixes the mlockall bug, it works
> > perfectly now.  Thanks!
> 
> great! This fix also means that we've got one more lock-break in the
> ext3 journalling code and one more lock-break in dcache.c. I've
> released-P1 with the fix included:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1

Hi,

cool, i can mlockall_test 500000  without an xrun in jackd! :) 

But it seems that this wasn't the only thing causing an xrun on jackd
client startup. I will try to take another look at the jackd source..

flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/

