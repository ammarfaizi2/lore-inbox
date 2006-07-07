Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWGGMTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWGGMTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWGGMTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:19:40 -0400
Received: from ns.suse.de ([195.135.220.2]:51629 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751039AbWGGMTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:19:39 -0400
To: Sean Kamath <skamath@anim.dreamworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about Kernel Reporting Sigfaults in <arch>/mm/fault.c
References: <44AD8E1F.2020509@anim.dreamworks.com>
From: Andi Kleen <ak@suse.de>
Date: 07 Jul 2006 14:19:31 +0200
In-Reply-To: <44AD8E1F.2020509@anim.dreamworks.com>
Message-ID: <p73bqs1ppyk.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Kamath <skamath@anim.dreamworks.com> writes:
> 
> exception_trace is set to 1 (line 296) and not used anywhere else in the file.
> 

It can be set using /proc/sys/debug/exception-trace

> The question(s): Is this intentional (to have segfaults reported on x86_64,

Yes.

> I admit, it would be nice to be able to toggle on and off segfault
> reporting in the kernel (from a system administration point of view, this
> is helpful to be able to go back to developers and say 'your program is
> crashing a lot' -- something necessary if you are protecting end-users from
> a lot of core files . . .) on all platforms.

It was originally was added when the port was still young to debug user
land faster, but it keeps people honest and is still very useful.

In fact it found some long standing bugs that were never noticed on i386 with
programs silently segfaulting.

-Andi
