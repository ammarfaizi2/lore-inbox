Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVAUSj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVAUSj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVAUSj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:39:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262451AbVAUSjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:39:16 -0500
Date: Fri, 21 Jan 2005 13:39:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@cpushare.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
In-Reply-To: <20050121093902.O469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu>
 <20050121093902.O469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Chris Wright wrote:
> * Ingo Molnar (mingo@elte.hu) wrote:

>> why do you need any kernel code for this? This seems to be a limited
>> ptrace implementation: restricting untrusted userspace code to only be
>> able to exec read/write/sigreturn.
>
> Only difference is in number of context switches, and number of running
> processes (and perhaps ease of determining policy for which syscalls
> are allowed).  Although it's not really seccomp, it's just restricted
> syscalls...

Yes, but do you care about the performance of syscalls
which the program isn't allowed to call at all ? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
