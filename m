Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbUDQLQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 07:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDQLQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 07:16:25 -0400
Received: from smtp.mailix.net ([216.148.213.132]:9841 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263918AbUDQLQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 07:16:23 -0400
Date: Sat, 17 Apr 2004 13:16:16 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20040417111616.GA1826@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <40810BA4.50803@colorfullife.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40810BA4.50803@colorfullife.com>
User-Agent: Mutt/1.5.6i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.140.227.8 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.140.227.8 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.140.227.8 listed in dnsbl.njabl.org]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.140.227.8 listed in dnsbl.sorbs.net]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1BEno1-0005xB-Vq)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul, Sat, Apr 17, 2004 12:49:08 +0200:
> Alex wrote:
> 
> >Ok. It's just that every provider of the _kernel_ interface to user
> >space has now to take care of being posix-compliant. Write the code for
> >checks, iow. That is not the case for "open", for instance.
> >And besides, with the patch applied the kernel is also posix compliant,
> >isn't it?
> >
> No. E.g. mq_notify(,&{.sigev_notify=SIGEV_THREAD) cannot be implemented 
> in kernel space. And sys_mq_getsetattr isn't posix compliant either - 
> the user space library must implement mq_getattr and mq_setattr on top 
> of the kernel API.

Ok. It's inevitable, as it looks.

> The kernel API was designed to be simple and flexible. Perhaps we want 
> to extend the kernel implementation in the future, and then a leading 
> slash could be used to indicate that we are using the new features.

and userspace will need to be updated (the slashes are cut off in libmqueue)

