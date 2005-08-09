Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVHIScr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVHIScr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVHIScr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:32:47 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:19256 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S964901AbVHIScq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:32:46 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,93,1122847200"; 
   d="scan'208"; a="13841472:sNHT172175520"
Message-ID: <42F8F6CC.7090709@fujitsu-siemens.com>
Date: Tue, 09 Aug 2005 20:32:44 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Wilkens <robw@optonline.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Signal handling possibly wrong
References: <42F8EB66.8020002@fujitsu-siemens.com> <1123612016.3167.3.camel@localhost.localdomain>
In-Reply-To: <1123612016.3167.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Wilkens wrote:
>>Kernel code blocks both "handled signal" _and_ sa_mask only if SA_NODEFER
>>isn't set.
>>
>>Which is the right behavior?
> 
> 
> Perhaps both?
> 
> I'm novice here, but if i'm reading the man page correctly, it says:
> 
> SA_NODEFER
>    Do not prevent the signal from being received from within
>    its  own  signal handler. 
> 	(they also imply that SA_NOMASK is the old name for this,
> 	which might make it clear what it's use is).
> 
> In which case blocking (masking) when it's not set is exactly what it's
> supposed to do.
> 
> -Rob

Yes. That's true.

But what about sa_mask? Description of SA_NODEFER and sa_mask both do not
say, that usage of sa_mask depends on SA_NODEFER.
But kernel only uses sa_mask, if SA_NODEFER isn't set.

So, I think man page and kernel are not consistent.

	Bodo
