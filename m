Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934961AbWKXQSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934961AbWKXQSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934963AbWKXQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:18:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934961AbWKXQSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:18:15 -0500
Message-ID: <45671B1A.6010202@redhat.com>
Date: Fri, 24 Nov 2006 08:17:30 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Hans Henrik Happe <hhh@imada.sdu.dk>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com> <200611232249.56886.hhh@imada.sdu.dk> <45662206.1070104@redhat.com> <20061124115004.GB32545@2ka.mipt.ru>
In-Reply-To: <20061124115004.GB32545@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Ulrich, why didn't you comment on previous interface, which had exactly
> _one_ index exported to userspace - it is only required to add implicit
> uidx and (if you prefer that way) additional syscall, since in previous
> interface both waiting and commit was handled by kevent_wait() with
> different parameters.

If you read my old mails you'll find that I'm pretty consistent wrt to 
the ring buffer interface.  The old code had other problems, not the 
missing exposure of the uidx value.

There is really not much disagreement here.  I just don't like the 
interface unnecessarily and misleadingly large by exposing the uidx 
value which is not useful to the userlevel code.  Just remove the 
element and stuff it into a kernel-internal struct for the queue and 
you're done.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
