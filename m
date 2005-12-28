Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVL1T5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVL1T5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVL1T5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:57:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:47334 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964893AbVL1T5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:57:49 -0500
Date: Wed, 28 Dec 2005 20:57:41 +0100
From: Andi Kleen <ak@suse.de>
To: John Blackwood <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, bugsy@ccur.com
Subject: Re: [PATCH] arch/x86_64/kernel/ptrace.c linux-2.6.14.4
Message-ID: <20051228195741.GA11515@wotan.suse.de>
References: <43AAC435.2090702@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AAC435.2090702@ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suppose that the read_32bit_tls() code could be instead pulled into
> a header file such as asm-x86_64/desc.h and shared between process.c
> and ptrace.c instead of having the read_tls_array() code below, but I
> didn't do that in this version of the patch.

Please do that. But not as an inline - make it out of line.
And read_ldt also doesn't need to be copied, it's already
in ldt.c and can be exported from there.

Thanks,
-Andi

