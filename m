Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVLUFdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVLUFdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLUFdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:33:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751084AbVLUFdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:33:32 -0500
Date: Tue, 20 Dec 2005 21:33:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Voluspa <lista1@telia.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc6
In-Reply-To: <20051221052101.1acb6cc4.lista1@telia.com>
Message-ID: <Pine.LNX.4.64.0512202131000.4827@g5.osdl.org>
References: <20051221052101.1acb6cc4.lista1@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Dec 2005, Voluspa wrote:
> 
> Not so in 2.6.15-rc2 to -rc6 (report http://marc.theaimsgroup.com/?l=linux-kernel&m=113498252000221&w=2 )
> Culprit is the following commit that I humbly ask to be removed/rewritten:
> 
> 2203d6ed448ff3b777ee6bb614a53e686b483e5b:
>
>     Fix ACPI processor power block initialization

I'd love to have it fixed, but quite frankly, if the choice is between a 
boot-time lockup and not using ACPI C1 sleep states, I'll take the 
non-working sleep states.

The code in question had comments that didn't match what it was doing, and 
apparently the ACPI guys couldn't say what was wrong..

But it might make sense to open a bugzilla entry so that it doesn't get 
lost.

		Linus
