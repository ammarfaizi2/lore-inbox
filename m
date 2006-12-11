Return-Path: <linux-kernel-owner+w=401wt.eu-S936362AbWLKPQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936362AbWLKPQx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936397AbWLKPQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:16:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46760 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936362AbWLKPQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:16:52 -0500
Message-ID: <457D764E.9040308@garzik.org>
Date: Mon, 11 Dec 2006 10:16:30 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take26-resend1 0/8] kevent: Generic event handling mechanism.
References: <1165848619971@2ka.mipt.ru>
In-Reply-To: <1165848619971@2ka.mipt.ru>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments:

* [oh, everybody will hate me for saying this, but...]  to me, "kevent" 
implies an internal kernel subsystem.  I would rather call it "uevent" 
or anything else lacking a 'k' prefix.

* I like the absolute timespec (and use of timespec itself)

* more on naming:  I think kevent_open would be more natural than 
kevent_init, since it opens a file descriptor.

* why is KEVENT_MAX not equal to KEVENT_POSIX_TIMER?  (perhaps answer 
this question in a comment, if it is not a mistake)

* Kill all the CONFIG_KEVENT_xxx sub-options, or hide them under 
CONFIG_EMBEDDED.  Application developers should NOT be left wondering 
whether or support for KEVENT_INODE was compiled into the kernel.

