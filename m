Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTKXWce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTKXWce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:32:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:38295 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbTKXWcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:32:33 -0500
Date: Mon, 24 Nov 2003 14:32:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <20031124222652.16351.qmail@web40910.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0311241429330.15101@home.osdl.org>
References: <20031124222652.16351.qmail@web40910.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Nov 2003, Bradley Chapman wrote:
>
> What sort of information would you like me to provide, sir? The bug you're
> discussing here isn't affecting me; CONFIG_PREEMPT has been solid on 2.6.0-test10.
> This is on a Gateway 600S laptop with a P4-M 2Ghz processor and an i845 Brookdale
> chipset.

Basically, there's something strange going on, which _seems_ to be memory
corruption, and seems to correlate reasonable well (but not 100%) with
CONFIG_PREEMPT.

It's actually unlikely to be preemption itself that is broken: it's much
more likely that some driver or other subsystem is broken, and preempt is
just better at triggering it by making some race conditions much easier to
see due to bigger windows for them to happen.

The problem is finding enough of a pattern to the reports to make sense of
what seems to be the common thread. A lot of people use preemption without
any trouble.

		Linus
