Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267877AbUG3XyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267877AbUG3XyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUG3XyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:54:05 -0400
Received: from the-village.bc.nu ([81.2.110.252]:44711 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267877AbUG3XyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:54:03 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-mm1-M5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20040730220006.GA6340@granada.merseine.nu>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040730081326.GA6384@elte.hu> <20040730220006.GA6340@granada.merseine.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091227658.5054.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 23:47:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 23:00, Muli Ben-Yehuda wrote:
> - both with and without the workaround, I get this:
> "Jul 30 08:42:40 hydra kernel: atkbd.c: Spurious ACK on
> isa0060/serio0. Some program, like XFree86, might be trying access
> hardware directly."

If you have an old Xorg or run XFree86 this may well be a real report.
Old X tries to bang the controller directly for some things. It also
turns up in some normal situations unfortunately and is very confusing
for end users. Really this printk should die ASAP.


