Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUAORTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUAORTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:19:30 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:42142
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265206AbUAORT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:19:27 -0500
Message-ID: <4006CB42.3040005@tmr.com>
Date: Thu, 15 Jan 2004 12:17:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
References: <20040112194829.A7078@infradead.org> <1073937102.3114.300.camel@compaq.xsintricity.com>
In-Reply-To: <1073937102.3114.300.camel@compaq.xsintricity.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> More or less.  But part of it also is that a lot of the patches I've
> written are on top of other patches that people don't want (aka, the
> iorl patch).  I've got a mlqueue patch that actually *really* should go
> into mainline because it solves a slew of various problems in one go,
> but the current version of the patch depends on some semantic changes
> made by the iorl patch.  So, sorting things out can sometimes be
> difficult.  But, I've been told to go ahead and do what I can as far as
> getting the stuff out, so I'm taking some time to try and get a bk tree
> out there so people can see what I'm talking about.  Once I've got the
> full tree out there, then it might be possible to start picking and
> choosing which things to port against mainline so that they don't depend
> on patches like the iorl patch.

If it leads to a more stable kernel, I don't see why iorl can't go in 
(user perspective) because RH is going to maintain it instead of trying 
to find a developer who is competent and willing to do the boring task 
of backfitting bugfixes to sub-optimal code.

The only problem I see would be getting testing before calling it 
stable. Putting out a "giant SCSI patch" for test, then into a -test 
kernel should solve that. The fact that RH is stuck supporting this for 
at least five years is certainly both motivation and field test for any 
changes ;-)

Clearly Marcello has the decision, but it looks from here as if 
stability would be improved by something like this. Assuming that no 
other vendor objects, of course.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
