Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030774AbWKUJKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030774AbWKUJKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030771AbWKUJKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:10:22 -0500
Received: from mail.axxeo.de ([82.100.226.146]:63892 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1030768AbWKUJKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:10:19 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Date: Tue, 21 Nov 2006 10:09:15 +0100
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
References: <11630606361046@2ka.mipt.ru> <45622228.80803@garzik.org> <456223AC.5080400@redhat.com>
In-Reply-To: <456223AC.5080400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211009.17417.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ulrich Drepper schrieb:
> Jeff Garzik wrote:
> > I think we have lived with relative timeouts for so long, it would be 
> > unusual to change now.  select(2), poll(2), epoll_wait(2) all take 
> > relative timeouts.
> 
> I'm not talking about always using absolute timeouts.
> 
> I'm saying the timeout parameter should be a struct timespec* and then 
> the flags word could have a flag meaning "this is an absolute timeout". 
>   I.e., enable both uses,, even make relative timeouts the default. 
> This is what the modern POSIX interfaces do, too, see clock_nanosleep.

I agree here. And while you are at it: Have it say "not before" vs. "not after".

<rant>
And if you call "absolute timeout" an "alarm" or "deadline" everyone will agree, 
that this is useful.

Timeout means "I ran OUT of TIME to do it" and this is by definition relative
to a starting point. A "deadline" is an absolute point in (wall) time where sth.
has to be ready and an "alarm" is an absolute point in (wall) time where sth.
is triggered (e.g. a bell rings on your "ALARM clock").

I don't know which person established that non-sense nomenclature about relative
and absolute timouts.
</rant>

Regards

Ingo Oeser
