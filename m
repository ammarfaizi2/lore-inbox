Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTEANCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTEANCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:02:13 -0400
Received: from unthought.net ([212.97.129.24]:48055 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261252AbTEANCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:02:12 -0400
Date: Thu, 1 May 2003 15:14:34 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Mark Grosberg <mark@nolab.conman.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030501131433.GH14372@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	Mark Grosberg <mark@nolab.conman.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304272114560.23296-100000@kwalitee.nolab.conman.org> <yw1xptn7z9m6.fsf@zaphod.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xptn7z9m6.fsf@zaphod.guide>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 03:36:17AM +0200, Måns Rullgård wrote:
> Mark Grosberg <mark@nolab.conman.org> writes:
...
> > But yeah, basically, something similar to NT's CreateProcess(). For the
> > cases where the one-step process creation is sufficient.
> 
> Is that the call that takes dozens of parameters?  Copying :-) that
> is, IMHO, straight against the UNIX philosophy.

I agree with Måns completely.

CreateProcess() is *horrible*.  It takes 10 arguments, several of them
being pointers to structures.  Ugh!

Besides, the CreateProcessAsUser() call (which takes 13 arguments IIRC)
demonstrates why such all-in-one-and-a-kitchen-sink calls are
fundamentally flawed.

In the few cases where they do not demand unnecessary arguments, they
simply lack the functionality that is actually needed.

I would argue that any time spent on replicating such monsters in Linux
would be far better spent optimizing the basic calls
(exec/fork/dup/close/fcntl/...) instead.


That was my 0.02 Euro on that one.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
