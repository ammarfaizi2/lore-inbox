Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbUCPQrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbUCPQma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:42:30 -0500
Received: from zero.aec.at ([193.170.194.10]:11527 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264029AbUCPQf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:35:59 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4
References: <1AajM-5vw-21@gated-at.bofh.it> <1Abpq-6Av-1@gated-at.bofh.it>
	<1Aj3K-5Fn-9@gated-at.bofh.it> <1AjwZ-65D-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 16 Mar 2004 17:14:47 +0100
In-Reply-To: <1AjwZ-65D-15@gated-at.bofh.it> (Andrew Morton's message of
 "Tue, 16 Mar 2004 11:00:25 +0100")
Message-ID: <m3brmwojk8.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> eh?  If there is any argument against this code it is that it is so simple
> that the thing which it abstracts is not worth abstracting.  But given that
> it is so unwasteful, this seems unimportant.

The bloat argument was about the additional pointer in the dynamic 
data structure (on a 64bit architecture it costs 12 bytes) 

Better would be to pass the callback to kref_put(), but then it would
be even better to just test the return value (callbacks are obfuscation
and should be avoided when not needed)

-Andi

