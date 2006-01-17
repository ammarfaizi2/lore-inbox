Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWAQIEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAQIEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWAQIEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:04:22 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49092
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751302AbWAQIEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:04:21 -0500
Subject: Re: ktimer not firing ?
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       kernelnewbies@nl.linux.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200601160945.47973.cloud.of.andor@gmail.com>
References: <200511171639.27565.cloud.of.andor@gmail.com>
	 <1132248488.10522.4.camel@localhost.localdomain>
	 <200601160945.47973.cloud.of.andor@gmail.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 09:04:44 +0100
Message-Id: <1137485084.17609.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 09:45 -0500, Claudio Scordino wrote:
> Hi,
> 
>    I know that ktimer is not yet part of the main tree of the Linux
> kernel...

And will never be. ktimers have been superseeded by hrtimers. The base
patch is merged into Linus tree and the high resolution patch can be
found here:

http://www.tglx.de/projects/hrtimers/2.6.15/

> However, the timer never fires. I checked the return value of the start and 
> it's correct (0 = success). Any idea of why the timer does not fire ?

Have you checked the expiry value after you called (re)start? It might
be far in the future.

	tglx


