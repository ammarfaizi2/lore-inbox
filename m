Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbVHPIi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVHPIi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVHPIi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:38:27 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:19899 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965144AbVHPIi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:38:26 -0400
Message-ID: <4301A7D0.9000507@aitel.hist.no>
Date: Tue, 16 Aug 2005 10:46:08 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no> <Pine.LNX.4.58.0508151550360.3553@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508151550360.3553@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 16 Aug 2005, Helge Hafting wrote:
>  
>
>>This was interesting.  At first, lots of kernels just kept working,
>>I almost suspected I was doing something wrong. Then the second last kernel
>>recompiled a lot of DRM stuff - and the crash came back!
>>The kernel after that worked again, and so the final message was:
>>
>>561fb765b97f287211a2c73a844c5edb12f44f1d is first bad commit
>>    
>>
>
>Ok, that definitely looks bogus. 
>
>That commit should not matter at _all_, it only changes ppc64 specific 
>things. 
>
>If the bug is sometimes hard to trigger, maybe one of the "good" kernels 
>wasn't good after all. That would definitely throw a wrench in the 
>bisection.
>  
>

The bisection search:
a46e812620bd7db457ce002544a1a6572c313d8a good
e0b98c79e605f64f263ede53344f283f5e0548be good
fd3113e84e188781aa2935fbc4351d64ccdd171b good
2757a71c3122c7653e3dd8077ad6ca71efb1d450 good
ba17101b41977f124948e0a7797fdcbb59e19f3e good, this one has got more testing,
as my default kernel to boot for the moment.

saw lots of drm recompile for the next one:
561fb765b97f287211a2c73a844c5edb12f44f1d bad

6ade43fbbcc3c12f0ddba112351d14d6c82ae476 good
I'll test this one more to see if it is a false positive, and I'll
also test a known bad kernel without DRM.

Helge Hafting


