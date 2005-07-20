Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVGTV2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGTV2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 17:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVGTV2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 17:28:02 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53184 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261508AbVGTV2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 17:28:00 -0400
Date: Wed, 20 Jul 2005 14:27:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bert.hubert@netherlabs.nl, relayfs-devel@lists.sourceforge.net,
       richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, zanussi@us.ibm.com
Subject: Re: [PATCH] Re: relayfs documentation sucks?
Message-Id: <20050720142732.761354de.pj@sgi.com>
In-Reply-To: <1121693274.12862.15.camel@localhost.localdomain>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050716210759.GA1850@outpost.ds9a.nl>
	<17113.38067.551471.862551@tut.ibm.com>
	<20050717090137.GB5161@outpost.ds9a.nl>
	<17114.31916.451621.501383@tut.ibm.com>
	<20050717194558.GC27353@outpost.ds9a.nl>
	<1121693274.12862.15.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve wrote:
> The reason I would like to see this merged, so kernel hackers don't need
> to constantly write there own logging buffers everytime you need to
> debug a complex area of the kernel.

But I doubt that relayfs, or anything resembling it, will accomplish
this purpose, at least for some of us, in many such situations.

When I'm debugging something requiring detailed tracing, I don't want
to have to think about whether the tracing tool has the particular
behaviour, performance, data loss, and other such characteristics
needed for my immediate needs.  It is easier to code up some little
ad hoc mechanism than it is to try to figure out whether some general
purpose mechanism is suitable and how to use the generic mechanism.

Invariably in any particular situation, there is some almost trivial
way to hack in something adequate, for very little effort, doing
things that would be utterly useless in some other case.

Such tracing mechanisms work to obtain major subsystem isolation,
by exposing the flow of data and control back and forth across a
major boundary, such as using strace for the initial isolation of a
problem that might be in user space, or might be in the kernel.

But for detailed work within a subsystem, the corners that one can
cut with ad hoc tools often make them vastly superior to general
purpose tools.

Even the best equipped of carpenters sometimes throw together some
temporary scaffolding using rough cut 2x4's (2 inch by 4 inch cross
section lumbar; I don't know what they're called in metric nations.)

If there are enough specific purposes for relayfs, fine.  But beware
of over generalizing its potential usefulness.  There is always the
risk of over designing it, adding additional flexibility and options
in an effort to gain customers, at the expense of making it less and
less obviously useful in a trivial way for any specific purpose.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
