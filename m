Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWCWE3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWCWE3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 23:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWCWE3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 23:29:35 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:45445 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S965202AbWCWE3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 23:29:34 -0500
Message-ID: <44222420.4040403@vilain.net>
Date: Thu, 23 Mar 2006 16:29:20 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>	<1142967011.10906.185.camel@localhost.localdomain> <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>I certainly have not.  I do feel that developing this just from the
>top down is the wrong way to do this.  
>  
>

OK, you said "just" the top down. That's fine, I can agree with that.
Obviously if any of the implementation of the top down features hits
ugliness that needs refactoring, that refactoring has to go first.

>In some of the preliminary
>patches we have found several pieces of code that we will have to
>touch that is currently in need of a cleanup.  That is why I have
>been cleaning up /proc.  sysctl is in need of similar treatment
>but is in less bad shape.
>  
>

I made a preliminary attempt to rebase the /proc hooks atop of your
work. I looked forward to being ready for if a patchset like this got
adopted to -mm to be able to hand that piece over :-).

The reason I didn't persue that to completion was I wasn't sure how I
would then submit it - relative to the -mm tree? I didn't want to
include your patches in my series.

It would be nice if someone could make a git branch on kernel.org for
each -mm release so it can be more easily imported to a git tree. Sure,
`stg import' might take a while for all 1,400 patches, but that's OK -
so long as Andrew's not waiting for it :-).

>I don't think that is the case on the fundamentals.  I think with pids
>I am an inch away from implementing a pid namespace that is both
>recursive, efficient, and can map all of the pids into another pid
>space if that is desirable.  Plus I can merge most of it incrementally
>in the existing kernel, before I even allow for multiple pid spaces.
>
>Which should reduce the patch for multiple pid namespaces to something
>reasonable to talk about.
>  
>

Well I see pids as just another virtualisable entity, but OK... if you
come up with anything I'm happy to rebase atop it.

>>What about going back to the very simple "struct container" on which to
>>build?
>>    
>>
>
>I guess my problem there is that isn't something on which to build
>that is something to hang things off of. 
>  
>

Yes, hanging things off is the intention, but they are both starting
points, just from different perspectives.

Sam.
