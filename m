Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTIKPG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTIKPG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:06:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41138 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261276AbTIKPG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:06:28 -0400
Message-ID: <3F608F66.8060601@pobox.com>
Date: Thu, 11 Sep 2003 11:06:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>	<20030911012708.GD3134@wotan.suse.de>	<20030910184414.7850be57.akpm@osdl.org>	<20030911014716.GG3134@wotan.suse.de>	<3F60837D.7000209@pobox.com>	<20030911162634.64438c7d.ak@suse.de>	<3F6087FC.7090508@pobox.com> <20030911165826.06f2fd16.ak@suse.de>
In-Reply-To: <20030911165826.06f2fd16.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, 11 Sep 2003 10:34:36 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>>X86_GENERIC is merely an optimization hint (currently it only changes the cache
>>>line size hint) It does not change anything related to correctness. Everything
>>>that handles correctness is checked unconditionally.
>>
>>When, building non-Pentium4-related code when CONFIG_MPENTIUM4 && 
>>!CONFIG_X86_GENERIC, it's OK that the code is incorrect for (picking 
>>example) AMD processors.
> 
> 
> No 2.6 changed that. On 2.6 you can exchange the kernels.
> 
> [that was mainly done for distributions, but helps other users too]


If distributions are not building with CONFIG_X86_GENERIC, then they're 
broken.  So it was rather pointless for 2.6 to "change that."

Luckily, CONFIG_X86_GENERIC allows us the opportunity to be _less_ 
generic when it's not defined, regardless of what you originally 
intended ;-)

	Jeff



