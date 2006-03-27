Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWC0GTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWC0GTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 01:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWC0GTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 01:19:24 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:15622 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750736AbWC0GTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 01:19:23 -0500
Message-ID: <442783E3.3050808@argo.co.il>
Date: Mon, 27 Mar 2006 08:19:15 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Arjan van de Ven <arjan@infradead.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl> <1143394195.3055.1.camel@laptopd505.fenrus.org> <4426D609.2050700@argo.co.il> <200603261618.30090.rob@landley.net>
In-Reply-To: <200603261618.30090.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Mar 2006 06:19:21.0627 (UTC) FILETIME=[6302A6B0:01C65166]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Sunday 26 March 2006 12:57 pm, Avi Kivity wrote:
>   
>> This is true for a small enough application. But things grow, libraries
>> are added, and includes keep pulling other includes in. Sooner or later
>> you'll have a collision.
>>     
>
> And you'll fix it when it happens.  Fact of life.
>   
Fixing it will mean breaking either the ABI of the kernel or of the 
large library you pulled in.

An ABI bug causes pain far beyond its size. Look at the trouble caused 
when some interfaces uses unsigned instead of u64. In kernel APIs, you 
just replace the type, but in the ABI, you add a new syscall or do some 
other hack.

Much better to get it right the first time, even if it's ugly. It's an 
ABI, not a beauty contest nominee.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

