Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbVHZX4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbVHZX4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 19:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVHZX4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 19:56:13 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:55525 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965177AbVHZX4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 19:56:12 -0400
Subject: Re: 2.6.13-rc7-rt3 compile fix
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <430FA93A.8040103@cybsft.com>
References: <430F86E7.9020605@cybsft.com>
	 <1125092197.5365.50.camel@localhost.localdomain>
	 <430FA93A.8040103@cybsft.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 26 Aug 2005 19:56:00 -0400
Message-Id: <1125100560.5365.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 18:43 -0500, K.R. Foley wrote:
> Steven Rostedt wrote:
> > Oops! my bad.  I saw that needed locking, but I didn't have the tracing
> > on (I was trying for internal deadlocks), so that part of the code
> > wasn't compiling.  If you turn off tracing it would compile :-)
> 
> Understood. ;-)
> 

I'm wrong again :-) It wasn't the tracing.  Here's the ifdef

#if defined(ALL_TASKS_PI) && defined(CONFIG_RT_DEADLOCK_DETECT)

And Ingo turned on ALL_TASKS_PI now.  But I had
CONFIG_RT_DEADLOCK_DETECT also turned off.

-- Steve


