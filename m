Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTJOQ7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTJOQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:59:09 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4880
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263652AbTJOQ65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:58:57 -0400
Subject: Re: PROBLEM: Preemptible kernel makes mpg123 skip a lot under
	2.6.0-testing7 and very high load average under low usage.
From: Robert Love <rml@tech9.net>
To: Dru <andru@treshna.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F8D3D97.4020802@treshna.com>
References: <3F8D3D97.4020802@treshna.com>
Content-Type: text/plain
Message-Id: <1066237128.1000.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-3) 
Date: Wed, 15 Oct 2003 12:58:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-15 at 08:29, Dru wrote:

> I'm not 100% certain its preemptiable kernel causing the problem, as i
> havn't tried disabling it in my kernel and re-testing it.

It is not caused by kernel preemption.  Your subject is a little
misleading, since you never tested without it.

Is the system load average ~2 (as you say in the next paragraph) when it
skips?  If nicing it fixes the problem, then we see that the system is
capable of meeting the scheduling deadlines.

Is the interactivity estimator giving it a penalty?  What does:

	ps -eo pid,user,priority,nice,command

show for mpg321 ?

> The other problem I am getting is occasionly I get very high load 
> average, 0.5-2 with low cpu usuage and well over my physical memory 
> free.  I'm not doing any disk acticivity so I'm not sure whats pushing 
> the load average up and if its completely normal
> or not.  The kernel and computer itself is quite stable and reliable so 
> far. I'm also running testing7 on a opetron, and while its cpu usage 
> normally sits between 2-5% usuage due all the applications it runs its 
> load average generally stays around the 0.00-0.02 mark.

Well, the load average is the number of runnable processes.  It is not
exactly the same as processor usage.

Are you having an average of one half to two processes runnable over a
five minute period?  The load average suggests so.

	Robert Love


