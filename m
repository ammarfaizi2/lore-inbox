Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUALTyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 14:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUALTyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 14:54:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266234AbUALTyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 14:54:50 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
In-Reply-To: <20040112194829.A7078@infradead.org>
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com>
	 <20040112151230.GB5844@devserv.devel.redhat.com>
	 <20040112194829.A7078@infradead.org>
Content-Type: text/plain
Message-Id: <1073937102.3114.300.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 12 Jan 2004 14:51:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 14:48, Christoph Hellwig wrote:
> On Mon, Jan 12, 2004 at 04:12:30PM +0100, Arjan van de Ven wrote:
> > > as the patch discussed in this thread, i.e. pure (partially
> > > vintage) bugfixes.
> > 
> > Both SuSE and Red Hat submit bugfixes they put in the respective trees to
> > marcelo already. There will not be many "pure bugfixes" that you can find in
> > vendor trees but not in marcelo's tree.
> 
> I haven't seen SCSI patches sumission for 2.4 from the vendors on linux-scsi
> for ages.  In fact I asked Jens & Doug two times whether they could sort out
> the distro patches for the 2.4 stack and post them, but it seems they're busy
> enough with real work so this never happened.

More or less.  But part of it also is that a lot of the patches I've
written are on top of other patches that people don't want (aka, the
iorl patch).  I've got a mlqueue patch that actually *really* should go
into mainline because it solves a slew of various problems in one go,
but the current version of the patch depends on some semantic changes
made by the iorl patch.  So, sorting things out can sometimes be
difficult.  But, I've been told to go ahead and do what I can as far as
getting the stuff out, so I'm taking some time to try and get a bk tree
out there so people can see what I'm talking about.  Once I've got the
full tree out there, then it might be possible to start picking and
choosing which things to port against mainline so that they don't depend
on patches like the iorl patch.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


