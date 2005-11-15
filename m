Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVKOIeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVKOIeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVKOIeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:34:17 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:32005 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751292AbVKOIeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:34:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bAstxN23KcB+1cKoniczShlcs8nRwdfGZyK8r9hHR5oyu7drE/CRZgla+x61QjPHduh6PbNHXKIgiWTdu43E7Xt8moV6Atlub5Y5QIhc5cUQoesZ+9zoUDcVArtpEXc6JIQ5TRsq0O/C/14wyRe83Ae3dmXluCDtwipPwXr3SCE=
Message-ID: <aec7e5c30511150034t5ff9e362jb3261e2e23479b31@mail.gmail.com>
Date: Tue, 15 Nov 2005 17:34:16 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 01/05] NUMA: Generic code
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, pj@sgi.com
In-Reply-To: <200511110516.37980.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110090920.8083.54147.sendpatchset@cherry.local>
	 <20051110090925.8083.45887.sendpatchset@cherry.local>
	 <200511110516.37980.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/05, Andi Kleen <ak@suse.de> wrote:
> On Thursday 10 November 2005 10:08, Magnus Damm wrote:
> > Generic CONFIG_NUMA_EMU code.
> >
> > This patch adds generic NUMA emulation code to the kernel. The code
> > provides the architectures with functions that calculate the size of
> > emulated nodes, together with configuration stuff such as Kconfig and
> > kernel command line code.
>
> IMHO making it generic and bloated like this is total overkill
> for this simple debugginghack. I think it is better to keep
> it simple and hiden it in a architecture specific dark corners, not expose it
> like this.

My plan with breaking out the NUMA emulation code was to merge my i386
stuff with the x86_64 code, but as you say - it might be overkill.

What do you think about the fact that real NUMA nodes now can be
divided into several smaller nodes?

/ magnus
