Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUJQFxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUJQFxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUJQFxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:53:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33934 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269065AbUJQFxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:53:19 -0400
Date: Sun, 17 Oct 2004 07:54:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
       Andrew Grover <andy.grover@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 4level page tables for Linux II
Message-ID: <20041017055436.GA29168@elte.hu>
References: <1097638599.2673.9668.camel@cube> <20041013092221.471f7232.ak@suse.de> <pan.2004.10.14.16.57.23.884792@smurf.noris.de> <c0a09e5c041014185545517031@mail.gmail.com> <20041015132823.GA26048@wohnheim.fh-wedel.de> <20041015135520.GA25999@kiste> <20041015233928.GA15449@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041015233928.GA15449@wohnheim.fh-wedel.de>
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


* Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> > The solution of your typo problem is typechecking in the compiler;
> > presumably it'll warn me if I try to store a pgd3 pointer in a pgd2
> > entry.
> 
> That should help somewhat, agreed.  Patches?

Type-checking of pte/pmd/pgd has been part of the kernel for the past 7
years or so. Andi's patch implements it for pml4's too.

the pt1/pt2/pt3/pt4 distinction makes more sense stylistically, but the
current patch should be engineered for as minimal impact as possible. 
Drastic changes to the MM namespace can be done later (if ever).

	Ingo
