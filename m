Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVEWXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVEWXLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVEWXJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:09:24 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:20595 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261218AbVEWXEq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:04:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uHzDoQOTyrKJ/szKba3HTccrtl12Yw3l7NiiqwGEVELVqzbc2VLzi0mLsE11rOCsmMLaVWHls0dBMYR1+qOGbxVaDTqkkSnzWf6Iuvc399mcj3Ct4ann/cMpLW/sYkOnG77vVmPze+Uj1XhbG5suGw+0JhU7EOloL4E14WcW+eI=
Message-ID: <d93f04c7050523160430f34d1d@mail.gmail.com>
Date: Tue, 24 May 2005 01:04:46 +0200
From: Hendrik Visage <hvjunk@gmail.com>
Reply-To: Hendrik Visage <hvjunk@gmail.com>
To: Scott Robert Ladd <lkml@coyotegulch.com>
Subject: Re: False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4291C38D.1040705@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505081445.26663.bernd.paysan@gmx.de>
	 <d93f04c705052112426ee35154@mail.gmail.com>
	 <428F9FA6.1000800@coyotegulch.com>
	 <d93f04c70505211500216d8614@mail.gmail.com>
	 <4291C38D.1040705@coyotegulch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/05, Scott Robert Ladd <lkml@coyotegulch.com> wrote:

> 
> Perhaps a comparison of my .config to yours might identify the source of
> your problem.

I think I've isolated the problem child: MSI's Dynamic Overclocking features...

The MSI "Core Cell" chipset will modify the CPU frequency within
certain parameters as the CPU needs more oomph (like a kernel
recompile :^P ), but will drop it once it heats up or things become
"unstable" or the CPU is getting idle again.

What I still need to ascertain, is whether the MSI K8N Neo Platinum
(nForce2 250) *do* have a HPET implementation or not, as my timer.c
only reports a PIT timer :(

-- 
Hendrik Visage
