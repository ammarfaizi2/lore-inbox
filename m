Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274557AbRJAEoT>; Mon, 1 Oct 2001 00:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274558AbRJAEoJ>; Mon, 1 Oct 2001 00:44:09 -0400
Received: from shell.aros.net ([207.173.16.19]:14610 "EHLO shell.aros.net")
	by vger.kernel.org with ESMTP id <S274557AbRJAEoA>;
	Mon, 1 Oct 2001 00:44:00 -0400
Date: Sun, 30 Sep 2001 22:44:27 -0600
From: Lawrence Gold <gold@shell.aros.net>
To: linux-kernel@vger.kernel.org
Subject: Success using "Athlon bug stomper" on VIA motherboard
Message-ID: <20010930224427.A42360@shell.aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch posted here

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.1/0817.html

allows my Epox 8kta3 motherboard to run 2.4.10 with Athlon optimizations.
Without this patch, I get immediate oopses on startup.  For those who are
curious, it's a Duron 800 and the BIOS is the revision from 18 May 2001.

P.S. Some more information in case it's helpful to anyone:

I used to use this motherboard with my 1.2GHz Athlon.  If I used an Athlon
kernel with CONFIG_X86_USE_3DNOW disabled, it would run well most of the
time.  However, certain operations, such as rapidly skipping through an
mpeg in MPlayer, could cause an oops.  Replacing my PC133 ram with PC166
seemed to have cleared up most of the oopses, but there were occasional
problems such as sig11 errors when running two compile jobs and playing an
mpeg.

I wonder if the PCI fixup could affect these problems as well.

Anyhow, good detective work!  IMHO, it should at least make its way in as
an experimental config option.

