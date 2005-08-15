Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVHOMaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVHOMaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbVHOMaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:30:10 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:46261 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932294AbVHOMaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:30:09 -0400
Message-ID: <43008C9C.60806@aitel.hist.no>
Date: Mon, 15 Aug 2005 14:37:48 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works fine.
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>  <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 12 Aug 2005, Helge Hafting wrote:
>  
>
>>>at the moment. The setup is fine with 2.6.13-rc4-mm1 x86-64, no 
>>>problems there.
>>>      
>>>
>>The problem still exists in 2.6.13-rc6.  Usually, all I get is a 
>>suddenly black display, solveable by resizing.
>>    
>>
>
>Is there any chance you could try bisecting the problem? Either just 
>binary-searching the patches or by using the git bisect helper scripts?
>
>Obviously the git approach needs a "good" kernel in git, but if 
>2.6.13-rc4-mm1 is ok, then I assume that 2.6.13-rc4 is ok too? That's a 
>fair number of changes:
>
>	 git-rev-list v2.6.13-rc4..v2.6.13-rc6 | wc
>	    340     340   13940
>
>but if you can tighten it up a bit (you already had trouble at rc5, I 
>think), it shouldn't require testing more than a few kernels.
>
>Git has had bisection support for a while, but the helper scripts to use 
>it sanely are fairly new, so I think you'd need the git-0.99.4 release for 
>those. But then you'd just do
>
>	git bisect start
>	git bisect bad v2.6.13-rc5
>	git bisect good v2.6.13-rc4
>
>and start bisecting (that will check out a mid-way point automatically, 
>you build it, and then do "git bisect bad" or "git bisect good" depending 
>on whether the result is bad or good - it will continue to try to find 
>half-way points until it has found the point that turns from good to 
>bad..)
>
>		Linus
>  
>
Ok, I have downlaoded git and started the first compile.
Git will tell when the correct point is found (assuming I
do the "git bisect bad/good" right), by itself?

Is there any way to make git tell exactly where between rc4 and rc5
each kernel is, so I can name the bzimages accordingly?

It takes some time to trigger the bug, so I could possibly end up with
a falsely ok kernel.  Is there a simple way to restart the search from 
that point,
or will I have to start over with rc4 and rc5 and say
git bisect good/bad until I reach the point of mistake?

Helge Hafting

 
