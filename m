Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVG1B2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVG1B2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVG1B2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:28:00 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:24776 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261489AbVG1BZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:25:48 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 21:25:28 -0400
Message-Id: <1122513928.29823.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 18:00 -0700, Daniel Walker wrote:
> Don't you break sched_find_first_bit() , seems it's dependent on a 
> 140-bit bitmap .

Oops! I forgot about that. With my custom kernels I had to change this
to use the generic find_first_bit routine. It's been a while since I
made these changes.  So when we really need to have custom settings, we
would have to change this.  I should have remembered this, since it did
cause me couple of days of debugging.  Anyway, I never did the
measurements, but does anyone know what the performance difference is
between find_first_bit and sched_find_first_bit? I guess I'll do it and
report back later.  This should also be in a comment around changing
these settings.

Thanks,

-- Steve


