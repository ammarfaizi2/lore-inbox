Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWE3MTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWE3MTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWE3MTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:19:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:12711 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751427AbWE3MTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:19:30 -0400
Date: Tue, 30 May 2006 14:19:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
Message-ID: <20060530121952.GA9625@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer> <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu> <1148991422.8610.8.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148991422.8610.8.camel@homer>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> I have nmi_watchdog=1.  I'll reboot with 0 and see if it'll trigger.
> 
> I found a warning.

> BUG: warning at kernel/lockdep.c:2398/check_flags()

this one could be related to NMI. We are already disabling NMI on 
x86_64, but i thought i had it fixed up for i386 - apparently not.

	Ingo
