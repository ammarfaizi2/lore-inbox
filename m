Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbTA1OXR>; Tue, 28 Jan 2003 09:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTA1OXR>; Tue, 28 Jan 2003 09:23:17 -0500
Received: from home.wiggy.net ([213.84.101.140]:54719 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S265587AbTA1OXQ>;
	Tue, 28 Jan 2003 09:23:16 -0500
Date: Tue, 28 Jan 2003 15:32:35 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128143235.GY4868@wiggy.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <200301281144.h0SBi0ld000233@darkstar.example.net> <20030128114840.GV4868@wiggy.net> <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk> <20030128130953.GW4868@wiggy.net> <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Alan Cox wrote:
> I'd not really pondered people who compile many drivers into their kernel
> instead of into the initrd. I guess a few people still do that.

Agreed - what you probably want to do is have a minimal kernel that
boots an initrd which loads modules for the rest. If the kernel is
small enough you don't care for its boot messages: if it fails the
hardware is screwed and your box has to be repaired (esp. if you are
dealing with embedded/special purpose systems where the people using
the box can't even see the hardware). 

Then have the bios/bootloader setup your pretty bootscreen and reset
it in the initrd when you load a fb driver.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
