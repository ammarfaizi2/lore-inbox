Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbSIYVKv>; Wed, 25 Sep 2002 17:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262025AbSIYVKv>; Wed, 25 Sep 2002 17:10:51 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:46586 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262020AbSIYVKu> convert rfc822-to-8bit; Wed, 25 Sep 2002 17:10:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.38-mm2 dbench $N times
Date: Wed, 25 Sep 2002 16:05:08 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <3D9103EB.FC13A744@digeo.com> <200209251351.58355.habanero@us.ibm.com> <253480000.1032987442@flay>
In-Reply-To: <253480000.1032987442@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209251605.08477.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 September 2002 3:57 pm, Martin J. Bligh wrote:
> > Pretty sure each dbench child does it's own write/read to only it's own
> > data. There is no sharing that I am aware of between the processes.
>
> Right, but if the processes migrate easily, there's still no CPU locality.
> Bill, do you want to try binding 1/32 of the processes to each CPU, and see
> if that makes your throughput increase?

Any stats to track migration over <x> time?  Would be intersting to see this 
in some sort of /proc/pid maybe?

> > How about running in tmpfs to avoid any disk IO at all?
>
> As far as I understand it, that won't help - we're operating out of
> pagecache anyway at this level, I think.

at dbench 512, that's about 512*20MB, 10GB (not 100% sure on that 20MB 
figure).  Have we hit a threshold at which this stuff gets written to disk?

> > Also, what's the policy for home node assignment on fork?  Are all of
> > these children getting the same home node assingnment??
>
> Policy is random - the scheduler lacks any NUMA comprehension at the
> moment. The numa sched mods would probably help a lot too.

Oops, confusing this run with the numa sched stuff earlier.

Andrew Theurer
