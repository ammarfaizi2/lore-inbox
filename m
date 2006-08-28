Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWH1Lrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWH1Lrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWH1Lrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:47:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:11177 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964834AbWH1Lrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:47:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TIa8OQe7Be/XpAGbRjZLgSvb7LMOmOZ4dGTcNSFzCJdDscPvjoMDx76peA1FzIEE7YDY36YU/9wB3hI3p2jHo6YgBAWCHGrGeVcWPNlfRws0yOGh/LAP/uceq/O9q0s/mYL8za5yLQY4pbdzOF+nSrz1afSWIAOwuaJO+fiibK8=
Message-ID: <b3f268590608280447s793f79fu8e6086cde1db8daf@mail.gmail.com>
Date: Mon, 28 Aug 2006 13:47:50 +0200
From: "Jari Sundell" <sundell.software@gmail.com>
To: "Nicholas Miell" <nmiell@comcast.net>
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
Cc: "Ulrich Drepper" <drepper@redhat.com>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>,
       "David Miller" <davem@davemloft.net>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>
In-Reply-To: <1156733977.2358.31.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11564996832717@2ka.mipt.ru> <44F208A5.4050308@redhat.com>
	 <1156733977.2358.31.camel@entropy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, Nicholas Miell <nmiell@comcast.net> wrote:
> Also complicated is the case where waiting threads have different
> priorities, different timeouts, and different minimum event counts --
> how do you decide which thread gets events first? What if the decisions
> are different depending on whether you want to maximize throughput or
> interactivity?

BTW, what is the intended use of the min event count parameter? The
obvious reason I can see, avoiding waking up a thread too often with
few queued events, would imo be handled cleaner by just passing a
parameter telling the kernel to try to queue more events.

With a min event count you'd have to use a rather low timeout to
ensure that events get handled within a resonable time.

Rakshasa
