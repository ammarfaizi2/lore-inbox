Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUBLQPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUBLQPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:15:06 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:25995 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266499AbUBLQPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:15:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 12 Feb 2004 08:15:01 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Christoph Hellwig <hch@infradead.org>
cc: RANDAZZO@ddc-web.com, <linux-kernel@vger.kernel.org>
Subject: Re: Semaphore with timeout....
In-Reply-To: <20040212135328.A2434@infradead.org>
Message-ID: <Pine.LNX.4.44.0402120806260.1760-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Christoph Hellwig wrote:

> On Thu, Feb 12, 2004 at 08:22:04AM -0500, RANDAZZO@ddc-web.com wrote:
> > 
> > In reference to loadable kernel modules... (drivers)
> > 
> > Is there a semaphore call that will either release with token or a specified
> > amt of time....
> 
> There's no down_timeout.  Unfortunately - at least the qlogic fibrechannel
> driver would love to have a primitive for that.
> 
> Look at drivers/scsi/qla2xxx/qla_os.c:qla2x00_down_timeout() for a horrible
> hack to emulate one.

Why wouldn't, a timer with a timer function that does signal_wake_up() 
plus a down_interruptible(), work for this?



- Davide



