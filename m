Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWJQWAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJQWAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWJQWAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:00:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWJQWA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:00:28 -0400
Date: Tue, 17 Oct 2006 15:00:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cal Peake <cp@absolutedigital.net>, Randy Dunlap <rdunlap@xenotime.net>,
       Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] Restore sysctl syscall option for non-embedded users
Message-Id: <20061017150016.8dbad3c5.akpm@osdl.org>
In-Reply-To: <1161123096.5014.0.camel@localhost.localdomain>
References: <453519EE.76E4.0078.0@novell.com>
	<20061017091901.7193312a.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	<1161123096.5014.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 23:11:36 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Maw, 2006-10-17 am 14:17 -0400, ysgrifennodd Cal Peake:
> > My dmesg gets spammed to all hell with these warnings. Can we keep this 
> > option easily visible till it gets ripped out Jan of 2007 (see 
> > Documentation/feature-removal-schedule.txt for reference)?
> 
> NAK
> 
> The problem is that this option is available at all. Deprecating
> syscalls especially trivial ones is fundamentally wrong. The correct fix
> is to make sysctl always present except as an option for embedded and
> not to deprecate it.

yes, it appears that we screwed that up, but I haven't got around to thinking about
it yet.

It does appear that so many things are using sys_sysctl() that any plan to
remove it completely is over-optimistic.

