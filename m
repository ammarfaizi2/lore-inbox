Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVAMKCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVAMKCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVAMKCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:02:47 -0500
Received: from imag.imag.fr ([129.88.30.1]:5801 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261538AbVAMKCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:02:45 -0500
Message-ID: <41E6472B.5020701@imag.fr>
Date: Thu, 13 Jan 2005 11:02:19 +0100
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050109 Fedora/1.7.5-3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sander@humilis.net
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: Re: NUMA or not on dual Opteron
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <200501121824.44327.rathamahata@ehouse.ru> <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org> <20050113094537.GB2547@favonius>
In-Reply-To: <20050113094537.GB2547@favonius>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Thu, 13 Jan 2005 11:02:24 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
> Linus Torvalds wrote (ao):
> 
>>On Wed, 12 Jan 2005, Sergey S. Kostyliov wrote:
>>
>>>2.6.10-rc1 hangs at boot stage for my dual opteron machine
>>
>>Oops, yes. There's some recent NUMA breakage - either disable
>>CONFIG_NUMA, or apply the patches that Andi Kleen just posted on the
>>mailing list (the second option much preferred, just to verify that
>>yes, that does fix it).
> 
> 
> I was under the impression that NUMA is useful on > 2-way systems only.
> Is this true, and if not, under what circumstances is NUMA useful on
> 2-way Opteron systems?
> 
> In other words: why should one want NUMA to be enabled or disabled for
> dual Opteron?
> 
> Thanks in advance.
> 

Numa needs to be enabled on bi-opteron systems because each processor 
controls part of the memory. unlike the intel memory architecture, where 
processors share the same bus to access memory.
Numa in opteron systems is thus required to allow sharing of memory .
