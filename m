Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266423AbTGES6s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 14:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266429AbTGES6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 14:58:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266423AbTGES6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 14:58:47 -0400
Date: Sat, 5 Jul 2003 12:14:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030705121416.62afd279.akpm@osdl.org>
In-Reply-To: <200307051728.12891.phillips@arcor.de>
References: <20030703023714.55d13934.akpm@osdl.org>
	<200307050216.27850.phillips@arcor.de>
	<200307051728.12891.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> The situation re scheduling in 2.5 feels much as 
> the vm situation did in 2.3

I've been trying to avoid thinking about that comparison.

I don't think it's really, really bad at present.  Just "should be a bit
better".

> Kgdb is no help in 
> diagnosing, as the kgdb stub also goes comatose, or at least the serial link 
> does.  No lockups have occurred so far when I was not interacting with the 
> system via the keyboard or mouse.  Suggestions?

Enable IO APIC, Local APIC, nmi watchdog.  Use serial console, see if you
can get a sysrq trace out of it.  That's `^A F T' in minicom.

I mean, it _has_ to be either stuck with interrupts on, or stuck with them off.
