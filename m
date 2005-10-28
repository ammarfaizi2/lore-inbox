Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVJ1IFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVJ1IFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbVJ1IFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:05:34 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:17583 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751428AbVJ1IFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:05:34 -0400
Message-ID: <4361DCE8.1090906@student.ltu.se>
Date: Fri, 28 Oct 2005 10:10:16 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com>
In-Reply-To: <20051028073049.GA27389@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>gcc is dumb, it doesn't realise that the variable will be filled by another
>function if its passed thus..
>
>	unsigned long foo
>	bar(&foo)
>	if (foo==1)
>		...
>
>With bar() filling in content of foo.
>I believe there's at least once instance of this in gcc bugzilla.
>  
>
Can we blame the compiler not knowing if the function bar will use the 
value of foo or initialize it?
For these cases, would it not be better to set them a value (for example 
0 or maybe UNINIT_DEFAULT)?
After all, the most common warning (as far as i can see) is about 
uninitialized variables.

Richard

