Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWJLWvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWJLWvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWJLWvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:51:55 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:27463 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751280AbWJLWvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:51:54 -0400
Date: Thu, 12 Oct 2006 15:51:46 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Paul Jackson <pj@sgi.com>
Cc: matthltc@us.ibm.com, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061012225146.GX7911@ca-server1.us.oracle.com>
Mail-Followup-To: Paul Jackson <pj@sgi.com>, matthltc@us.ibm.com,
	linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011220619.GB7911@ca-server1.us.oracle.com> <1160619516.18766.209.camel@localhost.localdomain> <20061012070826.GO7911@ca-server1.us.oracle.com> <20061012144420.089f3dce.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012144420.089f3dce.pj@sgi.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:44:20PM -0700, Paul Jackson wrote:
> > And what if you decide to
> > change it from "<pid>\n" to "<pid> <tgid>\n" per line? 
> 
> I think that's a good argument for never changing the format of one
> of these files, rather than a good argument for against a vector of
> scalars of identical type and purpose.

	Sure, no dispute here.  My argument point isn't that "vector of
scalars is inherently evil" (I'll leave that aside), it's that a
facility allowing or encouraging the format change or blowup is
unhealthy.

> And I'd agree that we should not use multiple values per file to
> represent a structure either - so I'd agree that we should not allow
> "<pid> <tgid>\n" in the first place.

	Cool, we're together on that as well.  I know that we can't
fully prevent stupidity, but encouraging better behavior is something I
always try to do.

> This configfs flap feels to me like someone slightly overgeneralized
> the lesson to be learned from previous problems displaying entire,
> evolving, structures in a single file, and then is being a bit over
> zealous enforcing the resulting rule.

	Someone (hi, it's me) rather tried to overspecialize configfs.
It's intentionally not all things to all people.  Kitchen sinks cause
clogs, as it were.
	And I'm intentionally overzealous enforcing it.  Better I need
to be beat over the head before I accept a good idea than I accept bad
ones with an "eh?"

Joel

-- 

 One look at the From:
 understanding has blossomed
 .procmailrc grows
	- Alexander Viro

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
