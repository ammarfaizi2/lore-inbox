Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWG1XOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWG1XOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161364AbWG1XOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:14:53 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:57559 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1161363AbWG1XOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:14:52 -0400
Subject: Re: [RFC] /dev/itimer
From: Nicholas Miell <nmiell@comcast.net>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060729004459.11a85a27.froese@gmx.de>
References: <20060728235951.7de534eb.froese@gmx.de>
	 <1154126015.2451.13.camel@entropy>  <20060729004459.11a85a27.froese@gmx.de>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 16:14:51 -0700
Message-Id: <1154128491.2451.19.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 00:44 +0200, Edgar Toernig wrote:
> Nicholas Miell wrote:
> >
> > Solaris lets you specify SIGEV_PORT in your struct sigevent which then
> > queues timer completions (or anything else that takes a struct sigevent,
> > like POSIX AIO) to a port and then all types of queued events (including
> > fd polling and user generated events) can be waited on and fetched with
> > a single function call.
> 
> There must be a reason that I haven't seen that used in the wild yet ...

It's fairly new (Solaris 10 only), so nobody knows about it, and
(anecdotally) it's full of bugs. The interface looks nice on paper,
though.

It's documented at
http://docs.sun.com/app/docs/doc/816-5168/6mbb3hrir?a=view
but docs.sun.com has gone to hell lately, so you might have trouble
accessing it.

http://partneradvantage.sun.com/protected/solaris10/adoptionkit/tech/man/port_create.txt
seems to work right now, but it doesn't have nice hyperlinks to the
related pages.

-- 
Nicholas Miell <nmiell@comcast.net>

