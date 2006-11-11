Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947273AbWKKQjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947273AbWKKQjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947272AbWKKQjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:39:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47497 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1947271AbWKKQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:39:52 -0500
Message-ID: <4555FCD0.7030505@torque.net>
Date: Sat, 11 Nov 2006 11:39:44 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Tejun Heo <htejun@gmail.com>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Jens Axboe <jens.axboe@oracle.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       monty@xiph.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <4554777B.7050708@torque.net> <508312.85189.qm@web31812.mail.mud.yahoo.com> <20061111104642.GA3356@infradead.org>
In-Reply-To: <20061111104642.GA3356@infradead.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Nov 10, 2006 at 12:08:15PM -0800, Luben Tuikov wrote:
>> P.S. I'd love to see SG_DXFER_TO_FROM_DEV completely ripped out
>> of sg.c, for obvious reasons.  Can you not duplicate the resid "fix"
>> it provides into "FROM_DEV" -- do apps really rely on it?
> 
> At the beginning of this thread it was mentioned cdparanio uses it.
> But in general we can't just rip out userland interfaces, we pretend
> to have a stable userspace abi (and except for the big sysfs mess that
> actually comes very close to the truth).
> 
> What we should do is to document very well what SG_DXFER_TO_FROM_DEV
> is doing and that odd name that's been chosen for it.  I'll prepare
> a patch for that.

Christoph,
It is documented and has been from day one. See scsi/sg.h
and http://sg.torque.net/sg/p/sg_v3_ho.html

Naming it is a challenge and at the time there
were no bidirectional transfers to/from a device
to worry about.

A more appropriate but impractical name might be:
SG_DXFER_TO_KERNEL_BUFFER_THEN_READ_FROM_DEV_VIA_KERNEL_BUFFER


Doug Gilbert

