Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbULEG7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbULEG7i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 01:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbULEG7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 01:59:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6276 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261266AbULEG7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 01:59:30 -0500
Date: Sun, 5 Dec 2004 07:59:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] NX: Fix noexec kernel parameter / x86_64
Message-ID: <20041205065921.GA26964@elte.hu>
References: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com> <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

> +		if (!memcmp(from, "noexec=", 7)) {
> +			extern void nonx_setup(char *str);
> +	
> +			nonx_setup(from + 7);
> +		}

looks good, but please put the prototype into a header.

	Ingo
