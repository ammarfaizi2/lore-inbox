Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUAORF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUAORF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:05:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5815 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265171AbUAORFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:05:18 -0500
Date: Thu, 15 Jan 2004 18:05:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Doug Ledford <dledford@redhat.com>, Arjan Van de Ven <arjanv@redhat.com>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040115170503.GY5507@suse.de>
References: <20040112092231.GG29177@suse.de> <1073914073.3114.263.camel@compaq.xsintricity.com> <4006C76B.3090206@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4006C76B.3090206@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15 2004, Bill Davidsen wrote:
> Doug Ledford wrote:
> >On Mon, 2004-01-12 at 04:22, Jens Axboe wrote:
> >
> >>On Mon, Jan 12 2004, Arjan van de Ven wrote:
> >>
> >>>On Mon, Jan 12, 2004 at 10:19:46AM +0100, Jens Axboe wrote:
> >>>
> >>>>... and still exists in your 2.4.21 based kernel.
> >>>
> >>>The RHL 2.4.21 kernels don't have the locking patch at all...
> >>
> >>But RHEL3 does:
> >>
> >>http://kernelnewbies.org/kernels/rhel3/SOURCES/linux-2.4.21-iorl.patch
> >>
> >>and the bug is there.
> >
> >
> >But in RHEL3 the bug is fixed already (not in a released kernel, but the
> >fix went into our internal kernel some time back and will be in our next
> >update kernel).  From my internal bk tree for this stuff:
> 
> "not in a released kernel..." Do I read this right? That you have a fix 
> for a critical bug and it hasn't been pushed to customers yet? How about 
> security bugs, has the fix you pushed in RH-9.0 been push to EL customers?

Calm down, it's a bug fix for a deadlock that _could_ trigger on SMP
only in SCSI error recovery.

-- 
Jens Axboe

