Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUALUEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUALUEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:04:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:2576 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264934AbUALUD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:03:58 -0500
Date: Mon, 12 Jan 2004 20:03:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Doug Ledford <dledford@redhat.com>
Cc: Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040112200351.A7409@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Doug Ledford <dledford@redhat.com>,
	Arjan Van de Ven <arjanv@redhat.com>,
	Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
	Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
	linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com> <20040112151230.GB5844@devserv.devel.redhat.com> <20040112194829.A7078@infradead.org> <1073937102.3114.300.camel@compaq.xsintricity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073937102.3114.300.camel@compaq.xsintricity.com>; from dledford@redhat.com on Mon, Jan 12, 2004 at 02:51:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 02:51:42PM -0500, Doug Ledford wrote:
> More or less.  But part of it also is that a lot of the patches I've
> written are on top of other patches that people don't want (aka, the
> iorl patch).

I'm wondering whether we want it now that 2.4 is basically frozen, but
I don't think there was a strong case against it say 4 or 5 month ago.
OTOH given that success (or lack thereof) I had pushing core changes
through Marcelo the chances it had even if scsi folks ACKed wouldn't
have been too high.

> I've got a mlqueue patch that actually *really* should go
> into mainline because it solves a slew of various problems in one go,
> but the current version of the patch depends on some semantic changes
> made by the iorl patch.  So, sorting things out can sometimes be
> difficult.  But, I've been told to go ahead and do what I can as far as
> getting the stuff out, so I'm taking some time to try and get a bk tree
> out there so people can see what I'm talking about.  Once I've got the
> full tree out there, then it might be possible to start picking and
> choosing which things to port against mainline so that they don't depend
> on patches like the iorl patch.

I personally just don't care enough about 2.4 anymore, so I don't think
I'll invest major amounts of time into it.  Even though the scsi changes
you've done are fairly huge I'm wondering whether we should just throw
it all in anyway - given that you said you'll have to care for the 2.4
scsi stack for a longer time for RH and no one else seems to be interested
doing maintaince.
