Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTG0CpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 22:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270655AbTG0CpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 22:45:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:23247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270654AbTG0CpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 22:45:04 -0400
Date: Sat, 26 Jul 2003 20:00:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Tomas Szepe <szepe@pinerecords.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus
In-Reply-To: <20030726194651.5e3f00bb.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0307261958220.5267-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Jul 2003, Randy.Dunlap wrote:
> 
> 2.  APM and ACPI aren't usable together, right?  so should the
> Kconfig file prevent both of them from being enabled?

They aren't used at the same time (as power management, at least), but
they should be usable together (ACPI doing things like CPU enumeration,
APM doing sleeps), and even more importantly, you should be able to 
compile both, and if ACPI is disabled or the BIOS doesn't have an ACPI 
table, the power management should just fall back to APM.

So they definitely aren't supposed to be mutually exclusive from a
configuration standpoint.

		Linus

