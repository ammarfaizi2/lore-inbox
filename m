Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTJRPHn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTJRPHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:07:43 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:49026 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261659AbTJRPHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:07:41 -0400
Date: Sat, 18 Oct 2003 08:07:40 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: John R Moser <jmoser5@student.ccbc.cc.md.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 freeze and grsecurity
Message-ID: <20031018150740.GB9043@ip68-4-255-84.oc.oc.cox.net>
References: <Pine.A32.3.91.1031018022547.30954A-100000@student.ccbc.cc.md.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.A32.3.91.1031018022547.30954A-100000@student.ccbc.cc.md.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 02:36:27AM -0400, John R Moser wrote:
> Is there any plan to impliment grsecurity into the final 2.6 release 
> before all the tests are finished and the thing is frozen totally?  I 

IMO a change this huge (and potentially controversial, see below) would
have needed to happen back in 2.5.x. Since that's in the past now, I
think it'll have to wait for 2.7.x.

[snip]
> countermeasures.  That is my understanding of PaX, grsecurity, and 
> seLinux in a nutshell.

PaX has competition:
http://people.redhat.com/mingo/exec-shield/

The pros and cons of ExecShield and PaX would need to be compared before
either one can be incorporated into the mainline kernel.

> Due to this "kill the problem at its source" approach to executable 

I would argue that grsec doesn't "kill the problem at its source", but
rather mitigates things when it's already too late to kill the problem
at its source. IMO "kill[ing] the problem at its source" requires fixing
programs to be non-exploitable.

Grsec certainly provides additional security, but I don't think we
should hype it too much either.

> security bugs, I think that grsec belongs in 2.6's core distribution, if 
> possible.  As far as I know, there is no 2.6 patch for grsecurity, but 
> I'd at least feel better knowing that Linus (and the other guy, who's 
> name escapes me right now) would at least consider allowing grsec to make 
> its way to the core distribution of the kernel even if a 2.6 patch 
> doesn't make it out until a few revisions in.  The generic security 

Adding grsec after 2.6 is released would be absolutely *ludicrous* IMO.
I think if it's going to go into the mainline kernel it needs the kind
of scrutiny and testing that would be best provided by inclusion in
2.7.

> increase is something that nobody can really argue with, although other 
> issues like the sudden strange inclusion of a whole new section in the 
> kernel for a revision may provide the other side of the argument.

I think "the other side of the argument" completely kills the idea for
now...

> GRsec is in no way all-powerful, but I really feel safer with it.

As do I, but I don't want to see anything like the 2.4 VM debacle
happen again in 2.6...

-Barry K. Nathan <barryn@pobox.com>
