Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbRCXFbi>; Sat, 24 Mar 2001 00:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131580AbRCXFb2>; Sat, 24 Mar 2001 00:31:28 -0500
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:31756 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131578AbRCXFbN>; Sat, 24 Mar 2001 00:31:13 -0500
Date: Fri, 23 Mar 2001 21:30:25 -0800
Message-Id: <200103240530.f2O5UP028482@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.0 warnings
In-Reply-To: <20010323235909.C3098@werewolf.able.es>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001 23:59:09 +0100, J . A . Magallon <jamagallon@able.es> wrote:
> 
> 
> On 03.23 Linus Torvalds wrote:
>> 
>> I agree. I'd much prefer that syntax also.
>> 
>> Or just remove the "default:" altogether, when it doesn't make any
>> difference.
>> 
> 
> Well, at last some sense. The same is with that ugly out: at the end
> of the function. Just change all that 'goto out' for a return.

No, no. Hell no. Multiple return paths in a function are a sure recipe
for errors creeping in later.

Just change the
	out:;
into 
	out:
		return;
and be done with it. Heck, it even looks like C code for a change. :-)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
