Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933513AbWKUPQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933513AbWKUPQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934377AbWKUPQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:16:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29334 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933513AbWKUPQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:16:57 -0500
Subject: Re: Re[2]: Where did find_bus() go in 2.6.18?
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <gregkh@suse.de>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-discuss@handhelds.org
In-Reply-To: <1697835939.20061121170846@gmail.com>
References: <1154868495.20061120003437@gmail.com>
	 <4560ECAF.1030901@gmail.com> <20061120001212.GA28427@suse.de>
	 <1148526308.20061120161322@gmail.com> <20061120173550.GV31879@stusta.de>
	 <1697835939.20061121170846@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 21 Nov 2006 16:16:34 +0100
Message-Id: <1164122195.31358.677.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   And removing a method from an integral, high-level API set is not the
> same as killing static variable in a hardware driver.

removing dead code that nobody is using should be applauded though. 
If we left all unused code in the kernel binary we'd soon have a 100Mb
vmlinuz file.... and an unmaintainable mess.

Actively removing parts of the kernel code that nobody is using is a
fight against that bloat (and yes the kernel has grown far too big
already, as I'm sure the handheld.org people already know... you
wouldn't want a 2x bigger vmlinuz right?...

Also, if an API or part of an API is unused, it's quite possibly an API
that SHOULDN'T be used, either because it's designed totally shite (like
sleep_on() is :), because the implementation is really horrid or because
it offers a function that nobody actually needs.

All three are grounds for removal to keep the vmlinuz side down in my
book. That isn't change for change's sake (I'm starting to sound like a
Harry Potter book) but that's an attempt to keep the bloat of the
vmlinuz down.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

