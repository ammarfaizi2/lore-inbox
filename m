Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269047AbTBXBc1>; Sun, 23 Feb 2003 20:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269052AbTBXBc1>; Sun, 23 Feb 2003 20:32:27 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:64249 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S269047AbTBXBc0>; Sun, 23 Feb 2003 20:32:26 -0500
Date: Sun, 23 Feb 2003 20:42:38 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rik van Riel <riel@imladris.surriel.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223204238.C15376@redhat.com>
References: <96700000.1045871294@w-hlinder> <m1smufn7xu.fsf@frodo.biederman.org> <Pine.LNX.4.50L.0302231126380.2206-100000@imladris.surriel.com> <m1of52nbyz.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1of52nbyz.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Feb 23, 2003 at 10:28:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 10:28:04AM -0700, Eric W. Biederman wrote:
> The problem.  There is no upper bound to how many rmap
> entries there can be at one time.  And the unbounded
> growth can overwhelm a machine.

Eh?  By that logic there's no bound to the number of vmas that can exist 
at a given time.  But there is a bound on the number that a single process 
can force the system into using, and that limit also caps the number of 
rmap entries the process can bring into existance.  Virtual address space 
is not free, and there are already mechanisms in place to limit it which, 
given that the number of rmap entries are directly proportion to the amount 
of virtual address space in use, probably need proper configuration.

> The goal is to provide an overall system cap on the number
> of rmap entries.

No, the goal is to have a stable system under a variety of workloads that 
performs well.  User exploitable worst case behaviour is a bad idea.  Hybrid 
solves that at the expense of added complexity.

		-ben
-- 
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
