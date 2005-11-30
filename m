Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbVK3R3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbVK3R3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVK3R3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:29:55 -0500
Received: from ns.suse.de ([195.135.220.2]:46009 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751476AbVK3R3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:29:54 -0500
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: PAT status?
References: <6278d2220511300404i27878f02mf5d8c948256d36e8@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Nov 2005 14:58:20 -0700
In-Reply-To: <6278d2220511300404i27878f02mf5d8c948256d36e8@mail.gmail.com>
Message-ID: <p73zmnlg5mr.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel J Blueman <daniel.blueman@gmail.com> writes:


> IIRC, the kernel (c. 2.6.14) still does nothing to setup the
> processors' PAT registers to enable write combining in one of the
> slots - the defaults the BIOS establishes do not cover this. Once this
> is done, drivers would readily be able to set page flags for a
> particular PAT slot, and MTRRs can (almost) be safely ignored.

As usual when something hasn't been done yet it's not that easy...

Problem is that they would very likely create very subtle problems
by creating conflicting mappings with the different cache attributes,
which leads to cache corruption and other nasty issues.

That is why more infrastructure is needed in the kernel to do this
properly.

-Andi
