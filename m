Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVKPFWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVKPFWd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVKPFWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:22:33 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:15771 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932582AbVKPFWc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:22:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tCJ5CX4FPnReoe3Dbnw5W7ZlfULxHZLNIl10Aesx/eqLl+mZHBeJblfq5/QiW9xqAOT0Ovv/AaBbwR4meDgqI8K+7AQzFn1u8PI3Yl8TK1hwH/bikc8F8ecEYxlfxmMApwmpPnxVubWxCTxtmQcPPCQz2+23CakicuSZHykdjtg=
Message-ID: <aec7e5c30511152122w70703fbfl98bd377fb6fb9af4@mail.gmail.com>
Date: Wed, 16 Nov 2005 14:22:31 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 01/05] NUMA: Generic code
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, pj@sgi.com
In-Reply-To: <200511151515.05201.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110090920.8083.54147.sendpatchset@cherry.local>
	 <200511110516.37980.ak@suse.de>
	 <aec7e5c30511150034t5ff9e362jb3261e2e23479b31@mail.gmail.com>
	 <200511151515.05201.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 15 November 2005 09:34, Magnus Damm wrote:
>
> >
> > My plan with breaking out the NUMA emulation code was to merge my i386
> > stuff with the x86_64 code, but as you say - it might be overkill.
> >
> > What do you think about the fact that real NUMA nodes now can be
> > divided into several smaller nodes?
>
> Is it really needed? I never needed it.  Normally numa emulation
> is just for basic numa testing, and for that just an independent
> split is good enough.

For testing, your NUMA emulation code is perfect IMO. But for memory
resource control your NUMA emulation code may be too simple.

With my patch, CONFIG_NUMA_EMU provides a way to partition a machine
into several smaller nodes, regardless if the machine is using NUMA or
not.

This NUMA emulation code together with CPUSETS could be seen as a
simple alternative to the memory resource control provided by CKRM.

/ magnus
