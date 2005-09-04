Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVIDIBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVIDIBk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVIDIBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:01:40 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:20157 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1751246AbVIDIBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:01:39 -0400
Date: Sun, 4 Sep 2005 01:01:02 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@istop.com>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904080102.GY8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Daniel Phillips <phillips@istop.com>, linux-cluster@redhat.com,
	wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <200509040240.08467.phillips@istop.com> <20050904002828.3d26f64c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904002828.3d26f64c.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 12:28:28AM -0700, Andrew Morton wrote:
> If there is already a richer interface into all this code (such as a
> syscall one) and it's feasible to migrate the open() tricksies to that API
> in the future if it all comes unstuck then OK.
> That's why I asked (thus far unsuccessfully):

	I personally was under the impression that "syscalls are not
to be added".  I'm also wary of the effort required to hook into process
exit.  Not to mention all the lifetiming that has to be written again.
	On top of that, we lose our cute ability to shell script it.  We
find this very useful in testing, and think others would in practice.

>    Are you saying that the posix-file lookalike interface provides
>    access to part of the functionality, but there are other APIs which are
>    used to access the rest of the functionality?  If so, what is that
>    interface, and why cannot that interface offer access to 100% of the
>    functionality, thus making the posix-file tricks unnecessary?

	I thought I stated this in my other email.  We're not intending
to extend dlmfs.  It pretty much covers the simple DLM usage required of
a simple interface.  The OCFS2 DLM does not provide any other
functionality.
	If the OCFS2 DLM grew more functionality, or you consider the
GFS2 DLM that already has it (and a less intuitive interface via sysfs
IIRC), I would contend that dlmfs still has a place.  It's simple to use
and understand, and it's usable from shell scripts and other simple
code.

Joel

-- 

"The first thing we do, let's kill all the lawyers."
                                        -Henry VI, IV:ii

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

