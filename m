Return-Path: <linux-kernel-owner+w=401wt.eu-S932474AbXARXYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbXARXYm (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbXARXYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 18:24:42 -0500
Received: from ns.suse.de ([195.135.220.2]:35246 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932474AbXARXYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 18:24:41 -0500
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] rdmsr_on_cpu, wrmsr_on_cpu
Date: Fri, 19 Jan 2007 10:21:16 +1100
User-Agent: KMail/1.9.1
Cc: Alexey Dobriyan <adobriyan@openvz.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       devel@vger.kernel.org
References: <20070118144527.GA6021@localhost.sw.ru> <45AFF12D.2070901@zytor.com>
In-Reply-To: <45AFF12D.2070901@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701191021.16706.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> HOWEVER -- and this is where things get gnarly -- the CPUID and MSR
> drivers would really like to be able to execute CPUID, WRMSR and RDMSR
> with the entire GPR register set (except the stack pointer) pre-set and
> post-captured, since it's highly likely that there are going to be
> nonstandard MSRs and CPUID levels (already witness Intel breaking the
> CPUID architecture by introducing %ecx dependencies.)

That looks like such a specialized requirement that I would suggest 
you keep that in the drivers. The interface for most users would be just
too ugly

-Andi

