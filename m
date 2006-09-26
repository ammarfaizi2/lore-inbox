Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWIZQqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWIZQqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWIZQqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:46:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751549AbWIZQqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:46:23 -0400
Date: Tue, 26 Sep 2006 09:46:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060926094607.815d126f.akpm@osdl.org>
In-Reply-To: <20060926102434.GA2134@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de>
	<1159220043.12814.30.camel@nigel.suspend2.net>
	<20060925144558.878c5374.akpm@osdl.org>
	<20060925224500.GB2540@elf.ucw.cz>
	<20060925160648.de96b6fa.akpm@osdl.org>
	<20060925232151.GA1896@elf.ucw.cz>
	<20060925172240.5c389c25.akpm@osdl.org>
	<20060926102434.GA2134@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 12:24:34 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Is "swapoff -a; echo disk > /sys/power/state" slow for you? If so, we
> have something reasonably easy to debug, if not, we'll try something
> else...

sony:/home/akpm# swapoff -a 
sony:/home/akpm# time (echo disk > /sys/power/state) 
echo: write error: no such device
(; echo disk > /sys/power/state; )  0.00s user 0.08s system 1% cpu 5.259 total

It took an additional two-odd seconds to bring the X UI back into a serviceable
state.

It'd be nice to increase that 1% CPU utilisation...
