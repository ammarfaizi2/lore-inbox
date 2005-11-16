Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVKPPIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVKPPIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVKPPIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:08:19 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:1920 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1030357AbVKPPIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:08:19 -0500
Message-ID: <437B453E.8070905@utah-nac.org>
Date: Wed, 16 Nov 2005 07:42:06 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <1132128212.2834.17.camel@laptopd505.fenrus.org> <20051116111812.4a1ea18a.grundig@teleline.es> <1132137638.2834.29.camel@laptopd505.fenrus.org> <p73oe4kpx6n.fsf@verdi.suse.de> <20051116135116.GA24753@wohnheim.fh-wedel.de>
In-Reply-To: <20051116135116.GA24753@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Wed, 16 November 2005 13:57:36 +0100, Andi Kleen wrote:
>  
>
>>I think it's in general risky. It's like balancing without a safety
>>net.  Might be a nice hobby, but for real production you want a safety
>>net.  That's simple because there are likely some code paths through
>>the code that need more stack space and that are rarely hit (and
>>cannot be easily found by static analysis, e.g. if they involve
>>indirect pointers or particularly complex configuration setups).
>>    
>>
>
>It isn't that hard to find such places.  Trouble is that you find so
>many of them and it takes quite a while to go through them all.  Years
>is a good unit for "quite a while".
>
>Jörn
>
>  
>
Map a blank ro page beneath the address range when stack memory is 
mapped is trap on page faults to the page when folks go off the end of 
th e stack.

Easy to find.

Jeff
