Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbTFARj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbTFARj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:39:29 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:47600 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264687AbTFARj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:39:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16090.15708.707835.911577@gargle.gargle.HOWL>
Date: Sun, 1 Jun 2003 13:52:28 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 and 2.5.70-mm3 hang on bootup
In-Reply-To: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
References: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bernhard> Both 2.5.70 and 2.5.70-mm3 hang right after "Ok, booting the
Bernhard> kernel..." on one of my test boxes (at the point, nothing
Bernhard> works, not even turning on/off the NumLock LED).

Bernhard> Hardware: ASUS A7S333, Athlon 2600+, 1 GB RAM
Bernhard> Compiler: gcc 3.3

Make sure you've turned off APIC mode, even for UP processors.  I'm
trying to get 2.5.70-mm3 working with SMP and I've narrowed it down to
an APIC problem.  Doesn't matter if I'm SMP or UP if I have APIC
enabled.  Booting with 'noapic' doesn't seem to help, but I'm probably
doing that part wrong.

My machine is a Dell Precision 610MT, dual 550 Mhz PIII Xeon, 440BX
chipset.  Latest BIOS from Dell, but it's a pretty stripped down one,
not much to poke at.

John
