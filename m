Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVLEUm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVLEUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVLEUm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:42:58 -0500
Received: from styx.suse.cz ([82.119.242.94]:33507 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751407AbVLEUm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:42:57 -0500
Date: Mon, 5 Dec 2005 21:42:56 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205214256.492421ad@griffin.suse.cz>
In-Reply-To: <200512052123.42357.mbuesch@freenet.de>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<200512052123.42357.mbuesch@freenet.de>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005 21:23:42 +0100, Michael Buesch wrote:
> This is __not__ "yet another stack". It is an _extension_.
> It is all about management frames, which the in-kernel code
> does not manage.

But this code should be part of the stack, as nearly every driver needs
it. Management handling should be really managed by the kernel. The same
applies to driver<->userspace communication - there is no need to bother
every driver with it. And so on.

The hard part is that every driver will need a slightly different amount
of this support depending on the amount of features that are provided by
firmware.

> We want a working device. The driver is in a state where it
> is more or less usable. What is missing, is code to handle
> management.

I understand.

> We tried the code from the RTL driver, but it is total crap.
> We dropped it again. We thought about using yet another out of
> kernel ieee80211 stack, but we began to write an extension
> to the in-kernel code. If that was right or wrong, well, that's
> the question.
> 
> If you _really_ think we should have used $EXTERNAL_STACK,
> go and patch the driver to work with it.

No. I just think we (everybody) should concentrate at one particular
stack, finish it and merge it. And I'm convinced Jouni's stack is
currently the best solution available - far far from perfect, with many
issues, but still the best - and it will finally save as much time.


-- 
Jiri Benc
SUSE Labs
