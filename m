Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSLQTZc>; Tue, 17 Dec 2002 14:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSLQTZb>; Tue, 17 Dec 2002 14:25:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30908 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266292AbSLQTZa>; Tue, 17 Dec 2002 14:25:30 -0500
Date: Tue, 17 Dec 2002 11:26:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "H. Peter Anvin" <hpa@transmeta.com>,
       Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <160470000.1040153210@flay>
In-Reply-To: <3DFF772E.2050107@transmeta.com>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <3DFF772E.2050107@transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's not as good as a pure user-mode solution using tsc could be, but
>> we've seen the kinds of complexities that has with multi-CPU systems, and
>> they are so painful that I suspect the sysenter approach is a lot more
>> palatable even if it doesn't allow for the absolute best theoretical
>> numbers.
> 
> The complexity only applies to nonsynchronized TSCs though, I would
> assume.  I believe x86-64 uses a vsyscall using the TSC when it can
> provide synchronized TSCs, and if it can't it puts a normal system call
> inside the vsyscall in question.

You can't use the TSC to do gettimeofday on boxes where they aren't 
syncronised anyway though. That's nothing to do with vsyscalls, you just
need a different time source (eg the legacy stuff or HPET/cyclone).

M.

