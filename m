Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbTIEU6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265822AbTIEU6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:58:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:14088
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S265818AbTIEU6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:58:25 -0400
Subject: Re: [PATCH] Nick's scheduler policy v12
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030905203903.GF19041@matchmail.com>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay>
	 <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay>
	 <20030905203903.GF19041@matchmail.com>
Content-Type: text/plain
Message-Id: <1062796123.1436.4.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 05 Sep 2003 17:08:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 16:39, Mike Fedyk wrote:

> Exactly.  Because the larger time slices for lower nice values came from
> O(1), not Con.

The larger timeslices may not help, but one reason why renicing X hurts
multimedia is that it gives a preference to the GUI over the multimedia
thread(s).

Look at it this way.  Assume renicing X does not _help_ whatever the
problem is (simply because the problem, in this case, is not stemming
from X).  Then giving X the higher priority and larger timeslice only
adversely affects the problem.

So, since the multimedia thread in (say) xmms is really unrelated to X
(its a separate thread and not doing any Xlib calls), it just hurts it.

> Linus added a patch to 2.5.65 or so that was supposed to allow nice 0 on X
> without any detrament.

That is the backboost thing.  It was ripped out, due to regressions in
SETI and elsewhere.

Nick added a similar thing back in, but he just removed it.  Its a shame
it cannot be made to work, because I like the idea.  I talked with Nick
and OLS about the ability of a forward+back boost combination to solve
our interactivity issues.  I really wish they panned out.

	Robert Love


