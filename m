Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267782AbUG3Seb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267782AbUG3Seb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbUG3Sea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:34:30 -0400
Received: from zero.aec.at ([193.170.194.10]:41740 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267781AbUG3Se3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:34:29 -0400
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
 kernels
References: <2nJ3t-34a-39@gated-at.bofh.it> <2nJmP-3eq-9@gated-at.bofh.it>
	<2nJG8-3p6-21@gated-at.bofh.it> <2nK9b-3PM-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 30 Jul 2004 20:34:15 +0200
In-Reply-To: <2nK9b-3PM-17@gated-at.bofh.it> (Jeff Garzik's message of "Fri,
 30 Jul 2004 20:20:09 +0200")
Message-ID: <m3brhx9wew.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:
>
> Certainly.  Therefore, changing from GFP_ATOMIC will increase
> likelihood of breakage, no?

No, the atomic checks prevents that. When the code wasn't broken
before on preemptive kernels it won't be broken now.

-Andi

