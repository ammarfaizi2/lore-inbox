Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWFIVjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWFIVjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWFIVjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:39:05 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:52703 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932239AbWFIVjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:39:04 -0400
Message-ID: <4489EA79.3000009@namesys.com>
Date: Fri, 09 Jun 2006 14:39:05 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Barry K. Nathan" <barryn@pobox.com>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060604133326.f1b01cfc.akpm@osdl.org> <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu> <20060604213432.GB5898@elte.hu> <986ed62e0606041503v701f8882la4cbead47ae3982f@mail.gmail.com> <20060605065444.GA27445@elte.hu> <986ed62e0606050058v21b457a7tb4da4da62cb7e4e3@mail.gmail.com> <20060605081220.GA30123@elte.hu>
In-Reply-To: <20060605081220.GA30123@elte.hu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Barry K. Nathan <barryn@pobox.com> wrote:
>
>  
>
>>On 6/4/06, Ingo Molnar <mingo@elte.hu> wrote:
>>    
>>
>>>reporting the first one only is necessary, because the validator cannot
>>>trust a system's dependency info that it sees as incorrect. Deadlock
>>>possibilities are quite rare in a kernel that is "in balance". Right now
>>>we are not "in balance" yet, because the validator has only been added a
>>>couple of days ago. The flurry of initial fixes will die down quickly.
>>>      
>>>
>>So, does that mean the plan is to annotate/tweak things in order to 
>>shut up *each and every* false positive in the kernel?
>>    
>>
>
>yes. 
>
Ingo is very much in the right here.  Things like locking are very hard
to debug, and require serious methodology.  It is worth the hassle.  I
hope we do more things like this in the future.
