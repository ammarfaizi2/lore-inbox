Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUIAANK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUIAANK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIAAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:10:40 -0400
Received: from zero.aec.at ([193.170.194.10]:40964 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269131AbUHaXnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:43:24 -0400
To: ncunningham@linuxmail.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
References: <2zpiO-72f-37@gated-at.bofh.it> <2zpC1-7fh-13@gated-at.bofh.it>
	<2zpVj-7yW-3@gated-at.bofh.it> <2zqeK-7JB-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 01 Sep 2004 01:43:18 +0200
In-Reply-To: <2zqeK-7JB-3@gated-at.bofh.it> (Nigel Cunningham's message of
 "Wed, 01 Sep 2004 01:30:10 +0200")
Message-ID: <m3d616j2ll.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> writes:
>
> Excuse me if I'm being ignorant, but I thought always_inline was
> introduced because with some recent versions of gcc, inline wasn't doing
> the job (suspend2, which requires a working inline, was broken by it for
> example). That is to say, doesn't the definition of always_inline vary
> with the compiler version?

It is just inline on some old gcc versions that didn't have 
__attribute__((always_inline)). But on these plain inline is usually fine 
- it will just inline. Only later versions of gcc broke their inlining
algorithm, but they luckily added this attribute as a workaround.

When you have functions that require inlining always mark them __always_inline

-Andi

