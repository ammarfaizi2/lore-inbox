Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUCXJmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 04:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUCXJmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 04:42:15 -0500
Received: from zero.aec.at ([193.170.194.10]:19720 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263141AbUCXJmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 04:42:12 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <1D3lO-3dh-13@gated-at.bofh.it> <1D3YZ-3Gl-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 24 Mar 2004 07:01:40 +0100
In-Reply-To: <1D3YZ-3Gl-1@gated-at.bofh.it> (Andrew Morton's message of
 "Wed, 24 Mar 2004 01:00:42 +0100")
Message-ID: <m3n066eqbf.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Which architectures are currently making their pre-page execute permissions
> depend upon VM_EXEC?  
> Would additional arch patches be needed for this?

Yes, they would need some straight forward minor patches e.g. in the
32bit emulation. IA64 would be a candidate I guess.

i386 could do it on NX capable CPUs with PAE kernels (but it would require 
backporting some fixes from x86-64). However currently it doesn't make
much sense because all x86 CPUs that support NX (AMD K8 currently only) 
support 64bit kernels and people can as well run 64bit kernels.
 
Doing it on i386 would only make sense if non 64bit capable CPUs ever get
NX. I heard VIA may be planning that, but so far there is nothing in their
shipping CPUs, so I guess we can skip that for now.

-Andi


