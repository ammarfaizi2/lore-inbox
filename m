Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269890AbUJHMUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269890AbUJHMUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269902AbUJHMUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:20:45 -0400
Received: from zero.aec.at ([193.170.194.10]:38927 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269890AbUJHMUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:20:43 -0400
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc -align options .config-settable
References: <2KBq9-2S1-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 08 Oct 2004 14:20:36 +0200
In-Reply-To: <2KBq9-2S1-15@gated-at.bofh.it> (Denis Vlasenko's message of
 "Fri, 01 Oct 2004 21:40:09 +0200")
Message-ID: <m3pt3t9zaj.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> Resend.
>
> With all alignment options set to 1 (minimum alignment),
> I've got 5% smaller vmlinux compared to one built with
> default code alignment.
>
> Rediffed against 2.6.9-rc3.
> Please apply.

I agree with the basic idea (the big alignments also always annoy
me when I look at disassembly), but I think your CONFIG options
are far too complicated. I don't think anybody will go as far as
to tune loops vs function calls. 

I would just do a single CONFIG_NO_ALIGNMENTS that sets everything to
1, that should be enough.

-Andi

