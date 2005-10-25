Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVJYWYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJYWYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVJYWYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:24:13 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:3816
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932453AbVJYWYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:24:12 -0400
Subject: Re: ktimers in RT causing bad bogomips and more.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1130278541.21118.49.camel@localhost.localdomain>
References: <1130278541.21118.49.camel@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 26 Oct 2005 00:26:46 +0200
Message-Id: <1130279207.8167.46.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 18:15 -0400, Steven Rostedt wrote:
> 	if (!hres->active)
> 		return CLOCK_EVT_RUN_CYCLIC;

I'm searching for the brown paperbag. 

Thats the startup code before switching over to high resolution, so it
should return 1, nothing else.

CLOCK_EVT_RUN_CYCLIC is a leftover of the initial implementation, which
did not take tick overruns into account. 

Thanks,

	tglx


