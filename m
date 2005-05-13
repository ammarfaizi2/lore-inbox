Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVEMXjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVEMXjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVEMXiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:38:10 -0400
Received: from terminus.zytor.com ([209.128.68.124]:6564 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262592AbVEMXg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:36:26 -0400
Message-ID: <428539EA.7000406@zytor.com>
Date: Fri, 13 May 2005 16:36:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86
 MTRR handling
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com> <42852CE2.4090102@zytor.com> <20050513232357.GB13846@redhat.com>
In-Reply-To: <20050513232357.GB13846@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > 
>  > Drop the vendor check; PAT is a generic x86 feature.  If AMD is not 
>  > compatible (see below), then use X86_VENDOR_AMD: and default:.
> 
> Done. Does transmeta have PAT btw ? I know newer VIA has it,
> but I haven't looked through the docs to double check its
> implementation yet.
> 

The Efficeon (TM8xxx) series does have PAT.
> 
>  > >+ * Note: On Athlon cpus PAT2/PAT3 & PAT6/PAT7 are both Uncacheable since 
>  > >+ *	 there is no uncached type.
>  > If one sets the PAT to "uncached", does one get the same function as 
>  > "uncachable"?
> 
> AIUI, only as long as we don't have an MTRR covering the same range marked WC.
> It seems to be the only thing I could find documenting the differences
> between 'uncached' and 'uncacheable' in this context.
> Though I've only looked through the Intel & AMD K8 docs, I don't have
> the K7 ones to hand.
> 

I mean, on the Athlon series, is it really necessary to use a different 
value?

	-hpa

