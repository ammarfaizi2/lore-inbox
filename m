Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271840AbTG2QIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTG2QHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:07:52 -0400
Received: from ns.suse.de ([213.95.15.193]:36874 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S271832AbTG2QGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:06:32 -0400
Date: Tue, 29 Jul 2003 18:06:30 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, vherva@niksula.hut.fi, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, torvalds@osdl.org
Subject: Re: [PATCH] NMI watchdog documentation
Message-ID: <20030729160630.GA2133@wotan.suse.de>
References: <200307291037.h6TAbX9G026932@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307291037.h6TAbX9G026932@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi, you have the numbers mixed up. mode 1 is I/O-APIC, mode 2 is local APIC,
> and x86-64 defaults nmi_watchdog to I/O-APIC mode.
> Now, is it the I/O-APIC or local APIC watchdog that doesn't work in x86-64?

Right, 1 and 2 need to be exchanged. Anyways local apic mode does not seem
to work, the kernel always reportss "NMI stuck" at bootup.
IO APIC mode for is default.

I have not tested if it works with a 32bit kernel on an Opteron box.

-Andi
