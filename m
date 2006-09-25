Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWIYXHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWIYXHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWIYXHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:07:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751275AbWIYXHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:07:05 -0400
Date: Mon, 25 Sep 2006 16:06:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060925160648.de96b6fa.akpm@osdl.org>
In-Reply-To: <20060925224500.GB2540@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de>
	<1159220043.12814.30.camel@nigel.suspend2.net>
	<20060925144558.878c5374.akpm@osdl.org>
	<20060925224500.GB2540@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 00:45:00 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Anyways this boils down to "find which drivers are delaying suspend
> and fix them".

The first step would be "find some way of identifying where all the time is
being spent".

Right now, netconsole gets disabled (or makes the machine hang) and most of
these machines don't have serial ports and the printk buffer gets lost
during resume.

The net result is that the machine takes a long time to suspend and resume,
and you don't have a clue *why*.

And this is a significant issue, IMO.  In terms of
niceness-of-user-interface, being able to suspend in twelve seconds instead
of twenty seven rates fairly highly...
