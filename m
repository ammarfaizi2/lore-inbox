Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWJRTNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWJRTNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWJRTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:13:15 -0400
Received: from natreg.rzone.de ([81.169.145.183]:58280 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1161264AbWJRTNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:13:14 -0400
Date: Wed, 18 Oct 2006 21:12:49 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Cal Peake <cp@absolutedigital.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com
Subject: Re: sysctl
Message-ID: <20061018191249.GA19927@aepfle.de>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com> <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org> <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, Cal Peake wrote:

> On Wed, 18 Oct 2006, Linus Torvalds wrote:
> 
> > There's apparently some library functions that has used it in the past, 
> > and I've seen a few effects of that:
> > 
> > 	warning: process `wish' used the removed sysctl system call
> > 
> > but the users all had fallback positions, so I don't think anything 
> > actually broke.
> 
> Agreed, nothing seems to have broken by removing it but the warnings sure 
> are ugly. Is there any reason to have them? If a program relies on sysctl 
> and the call fails the program should properly handle the error. That 
> should be all the warning that's needed (i.e. report the broken program 
> and get it fixed).

You will not see the warning for your failing app anyway due to the max
tries == 5 limit. With SLES10 the boot scripts trigger it already.
