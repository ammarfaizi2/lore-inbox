Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTLPWS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTLPWS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:18:29 -0500
Received: from zero.aec.at ([193.170.194.10]:56847 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263166AbTLPWS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:18:28 -0500
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
From: Andi Kleen <ak@muc.de>
Date: Tue, 16 Dec 2003 23:18:06 +0100
In-Reply-To: <13vyg-43O-7@gated-at.bofh.it> (Vladimir Kondratiev's message
 of "Tue, 16 Dec 2003 23:10:08 +0100")
Message-ID: <m3ekv4mmox.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <12KJ6-4F2-13@gated-at.bofh.it> <12Lvu-5X5-5@gated-at.bofh.it>
	<12XQ2-7Vs-9@gated-at.bofh.it> <12YsA-nt-1@gated-at.bofh.it>
	<130kQ-3A0-13@gated-at.bofh.it> <130Xy-4Ia-3@gated-at.bofh.it>
	<131Ac-5Qy-3@gated-at.bofh.it> <137cD-8eg-9@gated-at.bofh.it>
	<13kD2-1kF-11@gated-at.bofh.it> <13r1S-3FB-11@gated-at.bofh.it>
	<13vyg-43O-7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Kondratiev <vladimir.kondratiev@intel.com> writes:
>>
> Yes, separation into generic and platform specific part seems nice,
> but besides memory mapping and locking, all you have is
> very simple arithmetic. Does it worth the work for separation?
>
> For 64-bit world, agree, it could and should be done uniform.

Could you put the relevant code into an asm/ file for 2.6 then please?

Background: x86-64 shares the PCI code with i386 which just works
for both 32bit and 64bit currently. If it is all changeable in the asm/ 
file then I won't need to change it later again. Of course the fixmap
would work for x86-64 too, but just mapping the 256MB is much nicer
and preferable.

-Andi
