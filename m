Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVCKT7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVCKT7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVCKT4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:56:43 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18064 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261350AbVCKTuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:50:20 -0500
Message-ID: <4231F7C8.7070806@tmr.com>
Date: Fri, 11 Mar 2005 14:55:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin M. Forbes" <jmforbes@linuxtx.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.Stable and EXTRAVERSION
References: <20050309185331.GB19306@linuxtx.org>
In-Reply-To: <20050309185331.GB19306@linuxtx.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin M. Forbes wrote:
> With the new stable series kernels, the .x versioning is being added to
> EXTRAVERSION.  This has traditionally been a space for local modification.
> I know several distributions are using EXTRAVERSION for build numbers,
> platform and assorted other information to differentiate their kernel
> releases.
> I would propose that the new stable series kernels move the .x version
> information somewhere more official.  I certainly do not mind throwing
> together a patch to support DOTVERSION or what ever people want to call it.
> Is anyone opposed to such a change?

I think it will confuse scripts which expect something local in the 4th 
field. I confess that I have such, and that field is turned into a 
directory name during builds, so test results are saved in a proper 
place. I think vendors and people who care will just keep three digits, 
and those who want the last can make their EXTRAVERSION
    2.Joes_Bar_&_Grill_486
or whatever is needed.

Add to that the confusion of having mainline releases
   2.6.x.LOCAL
and stable be
   2.6.x.y.LOCAL
and you really make work for people who do things with scripts. This is 
probably not an issue for humans, and people could program around it, 
but I think it's a solution to a non-problem. Vendors will have the 
-stable and their own patches, so they probably will only keep three 
fields anyway.

And don't even suggest tell Linus to start calling mainline releases 
2.6.x.0 because that would probably break even more things.

Leave well enough alone!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
