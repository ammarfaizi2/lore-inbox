Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbUBXHcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 02:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUBXHcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 02:32:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:8861 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262193AbUBXHcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 02:32:14 -0500
Date: Mon, 23 Feb 2004 23:32:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Kerin <eric@bootseg.com>
Cc: alexn@telia.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.3 oops at kobject_unregister, alsa & aic7xxx
Message-Id: <20040223233218.73e61a9e.akpm@osdl.org>
In-Reply-To: <1077606462.3172.38.camel@opiate>
References: <1077546633.362.28.camel@boxen>
	<20040223160716.799195d0.akpm@osdl.org>
	<1077602725.3172.19.camel@opiate>
	<20040223221740.5786b0b3.akpm@osdl.org>
	<1077606462.3172.38.camel@opiate>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Kerin <eric@bootseg.com> wrote:
>
> The AIC drivers are currently coded to unload (by returning -ENODEV from
>  the init function) if no devices are found, so the exit function never
>  gets called, leaving the stale entries.

Oh, OK, leaving the PCI driver registered.

>  There's a 2nd patch in the above thread that changes those modules to
>  stay loaded even if no devices are found, which Arjan V pointed out was
>  the preferred way for drivers to work.

Sounds good.  Do you have that patch handy?
