Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbUCXKXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUCXKXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:23:37 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:57230 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263258AbUCXKXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:23:35 -0500
Message-ID: <4061619F.4020704@stesmi.com>
Date: Wed, 24 Mar 2004 11:23:27 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
References: <1D3lO-3dh-13@gated-at.bofh.it> <1D3YZ-3Gl-1@gated-at.bofh.it> <m3n066eqbf.fsf@averell.firstfloor.org>
In-Reply-To: <m3n066eqbf.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi.

>>Which architectures are currently making their pre-page execute permissions
>>depend upon VM_EXEC?  
>>Would additional arch patches be needed for this?
> 
> 
> Yes, they would need some straight forward minor patches e.g. in the
> 32bit emulation. IA64 would be a candidate I guess.
> 
> i386 could do it on NX capable CPUs with PAE kernels (but it would require 
> backporting some fixes from x86-64). However currently it doesn't make
> much sense because all x86 CPUs that support NX (AMD K8 currently only) 
> support 64bit kernels and people can as well run 64bit kernels.
>  
> Doing it on i386 would only make sense if non 64bit capable CPUs ever get
> NX. I heard VIA may be planning that, but so far there is nothing in their
> shipping CPUs, so I guess we can skip that for now.

Well, there's also the case that (unknown if rumour or confirmed) there
will be AthlonXPs based on the K8 core that do NOT run 64bit code.

I would THINK they would include the NX bit but that's just a guess of
course.

// Stefan
